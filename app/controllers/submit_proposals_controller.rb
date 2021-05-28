class SubmitProposalsController < ApplicationController
  def new
    @proposals = ProposalForm.new
  end

  def create
    proposal = Proposal.find params[:proposal]
    SubmitProposalService.new(proposal, params).save_answers
    @publish = true
   	redirect_to edit_proposal_path(proposal, publish: @publish)
  end
end
