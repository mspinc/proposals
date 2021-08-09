class SubmittedProposalsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_proposals, only: %i[index download_csv]
  before_action :set_proposal, only: %i[show staff_discussion send_emails]

  def index; end

  def show; end

  def download_csv
    send_data @proposals.to_csv, filename: "submitted_proposals.csv"
  end

  def staff_discussion
    return unless @ability.can?(:manage, Email)

    @staff_discussion = StaffDiscussion.new
    discussion = params[:discussion]
    if @staff_discussion.update(discussion: discussion, proposal_id: @proposal.id)
      redirect_to submitted_proposal_url(@proposal),
                  notice: "Your comment was added!"
    else
      redirect_to submitted_proposal_url(@proposal),
                  alert: @staff_discussion.errors.full_messages
    end
  end

  def send_emails
    return unless @ability.can?(:manage, Email)

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
      query = ProposalFiltersQuery.new(Proposal.active_proposals)
      @proposals = query.find(params)
    else
      @proposals = Proposal.active_proposals
    end
  end

  def set_proposal
    @proposal = Proposal.find_by(id: params[:id])
  end
end
