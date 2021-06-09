class SubmitProposalsController < ApplicationController
  def new
    @proposals = ProposalForm.new
  end

  def create
    @proposal = Proposal.find params[:proposal]
    @proposal.update(proposal_params)
    @publish = true
    if SubmitProposalService.new(@proposal, params).save_answers
      redirect_to thanks_submit_proposals_path, notice: 'Your proposal has been submitted'
    else
      redirect_to edit_proposal_path(@proposal, publish: @publish)
    end
  end

  def thanks; end

  private

  def proposal_params
    params.permit(:title, :year, :subject_id, ams_subject_ids: [])
  end
end
