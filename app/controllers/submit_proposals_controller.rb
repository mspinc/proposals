class SubmitProposalsController < ApplicationController
  def new
    @proposals = ProposalForm.new
  end

  def create
    @proposal = Proposal.find params[:proposal]
    update_proposal
    SubmitProposalService.new(@proposal, params).save_answers
    @publish = true
   	redirect_to edit_proposal_path(@proposal, publish: @publish)
  end

  def update_proposal
    @proposal.update(proposal_params)
  end

  private

  def proposal_params
    params.permit(:title, :year)
  end
end
