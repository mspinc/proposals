class SubmittedProposalsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_proposals, only: %i[index download_csv]
  before_action :set_proposal, except: %i[index download_csv]
  
  def index; end

  def show; end

  def download_csv
    send_data @proposals.to_csv, filename: "submitted_proposals.csv"
  end

  def edit_flow
    params[:ids]&.split(',')&.each do |id|
      @proposal = Proposal.find_by(id: id.to_i)
      post_to_editflow
    end

    respond_to do |format|
      format.js { render js: "window.location='/submitted_proposals'" }
      format.html { redirect_to submitted_proposals_path, notice: 'Successfully sent proposal(s) to EditFlow!' }
    end
  end

  def staff_discussion
    @staff_discussion = StaffDiscussion.new
    discussion = params[:discussion]
    if @staff_discussion.update(discussion: discussion,
                                proposal_id: @proposal.id)
      redirect_to submitted_proposal_url(@proposal),
                  notice: "Your comment was added!"
    else
      redirect_to submitted_proposal_url(@proposal),
                  alert: @staff_discussion.errors.full_messages
    end
  end

  def send_emails
    @email = Email.new(email_params.merge(proposal_id: @proposal.id))
    if @email.save
      @email.email_organizers
      redirect_to submitted_proposal_url(@proposal),
                  notice: "Sent email to proposal organizers."
    else
      redirect_to submitted_proposal_url(@proposal),
                  alert: @email.errors.full_messages
    end
  end

  def destroy
    @proposal.destroy
    respond_to do |format|
      format.html { redirect_to submitted_proposals_url,
                    notice: "Proposal was successfully deleted." }
      format.json { head :no_content }
    end
  end

  def approve_status
    @proposal.update(status: 'approved')
    redirect_to submitted_proposals_url(@proposal),
                notice: "Proposal has been approved."
  end

  def decline_status
    @proposal.update(status: 'declined')
    redirect_to submitted_proposals_url(@proposal),
                notice: "Proposal has been declined."
  end

  private

  def query_params?
    (params.keys & %i[firstname lastname subject_area keywords workshop_year
                      proposal_type]).any?
  end

  def email_params
    params.permit(:subject, :body, :revision)
  end

  def set_proposals
    if query_params?
      query = ProposalFiltersQuery.new(Proposal.order(:created_at))
      @proposals = query.find(params)
    else
      @proposals = Proposal.order(:created_at)
    end
  end

  def latex_temp_file
    "propfile-#{current_user.id}-#{@proposal.id}.tex"
  end

  def create_pdf_file
    prop_pdf = ProposalPdfService.new(@proposal.id, latex_temp_file, 'all')
    prop_pdf.pdf

    @year = @proposal&.year || Date.current.year.to_i + 2
    pdf_file = render_to_string layout: "application",
                                inline: prop_pdf.to_s, formats: [:pdf]

    @pdf_path = "#{Rails.root}/tmp/submit-#{DateTime.now.to_i}.pdf"
    File.open(@pdf_path, 'w:binary') do |file|
      file.write(pdf_file)
    end
  end

  def post_to_editflow
    create_pdf_file

    country_code = Country.find_country_by_name(@proposal.lead_organizer.country)
    co_organizers = @proposal.invites.where(invited_as: 'Co Organizer')
    country_code_organizers = Country.find_country_by_name(co_organizers.first.person.country)
    query = <<END_STRING
            mutation {
              article: submitArticle(data: {
                authors: [{
                  email: "#{@proposal.lead_organizer.email}"
                  givenName: "#{@proposal.lead_organizer.firstname}"
                  familyName: "#{@proposal.lead_organizer.lastname}"
                  nameInOriginalScript: ""
                  institution: "#{@proposal.lead_organizer.affiliation}"
                  countryCode: "#{country_code.alpha2}"
                }, {
                  email: "#{co_organizers.first.email}"
                  givenName: "#{co_organizers.first.firstname}"
                  familyName: "#{co_organizers.first.lastname}"
                  institution: "#{co_organizers.first.person.affiliation}"
                  countryCode: "#{country_code_organizers.alpha2}"
                  mrAuthorID: 12345
                }]
                correspAuthorEmail: "#{@proposal.lead_organizer.email}"
                title: "#{@proposal.title}"
                sectionAbbrev: "#{@proposal.subject.code}"
                primarySubjects: {
                  scheme: "MSC2020"
                  codes: ["00-01"]
                }
                secondarySubjects: {
                  scheme: "MSC2020"
                  codes: ["00B05", "00A07"]
                }
                abstract: "#{@proposal.title}"
                files: [{
                  role: "main"
                  key: "fileMain"
                }]
              }) {
                identifier
              }
            }
END_STRING

    response = RestClient.post ENV['EDITFLOW_API_URL'],
      { query: query, fileMain: File.open(@pdf_path) },
      { x_editflow_api_token: ENV['EDITFLOW_API_TOKEN'] }
    puts response

    if response.body.include?("errors")
      Rails.logger.debug { "\n\n*****************************************\n\n" }
      Rails.logger.debug { "EditFlow POST error:\n #{response.body.inspect}\n" }
      Rails.logger.debug { "\n\n*****************************************\n\n" }
      flash[:alert] = "Error sending data!"
    else
      flash[:notice] = "Data sent to EditFlow!"
    end
  end

  def set_proposal
    @proposal = Proposal.find_by(id: params[:id])
  end
end
