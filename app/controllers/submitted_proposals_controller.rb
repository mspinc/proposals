class SubmittedProposalsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_proposals, only: %i[index download_csv]
  before_action :set_proposal, only: %i[show birs_discussion send_emails]

  def index; end

  def show; end

  def download_csv
    send_data @proposals.to_csv, filename: "submitted_proposals.csv"
  end

  def birs_discussion
    @birs_discussion = BirsDiscussion.new
    discussion = params[:discussion]
    if @birs_discussion.update(discussion: discussion, proposal_id: @proposal.id)
      redirect_to submitted_proposal_url(@proposal), notice: "Successfully, Added your comment in discussion!"
    else
      redirect_to submitted_proposal_url(@proposal), alert: @birs_discussion.errors.full_messages
    end
  end

  # rubocop:disable Metrics/AbcSize
  def send_emails
    @email = Email.new
    status_update if params[:revision].to_i == 1
    if @email.update(subject: params[:subject], body: params[:body], revision: params[:revision],
                     proposal_id: @proposal.id)
      email_send
      redirect_to submitted_proposal_url(@proposal), notice: "Send emails to lead organizer and organizers."
    else
      redirect_to submitted_proposal_url(@proposal), alert: @email.errors.full_messages
    end
  end
  # rubocop:enable Metrics/AbcSize

  private

  # rubocop:disable Metrics/AbcSize
  def email_send
    email = @proposal.lead_organizer.email
    @organizer = @proposal.lead_organizer.fullname
    ProposalMailer.with(email_data: @email, email: email, organizer: @organizer).staff_send_emails.deliver_later

    invites = @proposal.invites.where(invited_as: 'Co Organizer')
    invites&.each do |invite|
      email = invite.email
      @organizer = invite.person.fullname
      ProposalMailer.with(email_data: @email, email: email, organizer: @organizer).staff_send_emails.deliver_later
    end
  end
  # rubocop:enable Metrics/AbcSize

  # rubocop:disable Metrics/AbcSize
  def query_params?
    params[:firstname].present? || params[:lastname].present? ||
      params[:subject_area].present? || params[:keywords].present? ||
      params[:workshop_year].present? || params[:proposal_type].present?
  end
  # rubocop:enable Metrics/AbcSize

  def set_proposals
    if query_params?
      query = ProposalFiltersQuery.new(Proposal.active_proposals)
      @proposals = query.find(params)
    else
      @proposals = Proposal.active_proposals
    end
  end

  def status_update
    @proposal.update(status: 'revision_requested')
    version = Answer.maximum(:version).to_i
    answers = Answer.where(proposal_id: @proposal, version: version)
    answers.each do |answer|
      answer = answer.dup
      answer.save
      version = answer.version + 1
      answer.update(version: version)
    end
  end

  def set_proposal
    @proposal = Proposal.find_by(id: params[:id])
  end
end
