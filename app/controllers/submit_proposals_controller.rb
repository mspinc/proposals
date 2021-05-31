class SubmitProposalsController < ApplicationController
  def new
    @proposals = ProposalForm.new
  end

  def create
    @proposal = Proposal.find params[:proposal]
    update_proposal
    SubmitProposalService.new(@proposal, params).save_answers
    redirect_to proposals_path
  end

  def update_proposal
    @proposal.update(title: params[:title], year: params[:year])
  end
end
