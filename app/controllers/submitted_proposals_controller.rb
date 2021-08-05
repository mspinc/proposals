class SubmittedProposalsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_proposals, only: %i[index download_csv]
  before_action :set_proposal, except: %i[index download_csv]
  
  def index; end

  def show; end

  def download_csv
    send_data @proposals.to_csv, filename: "submitted_proposals.csv"
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

  def set_proposal
    @proposal = Proposal.find_by(id: params[:id])
  end
end
