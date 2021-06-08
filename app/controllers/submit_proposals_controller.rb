class SubmitProposalsController < ApplicationController
  def new
    @proposals = ProposalForm.new
  end

  def create
    @proposal = Proposal.find params[:proposal]
    @proposal.update(proposal_params)
    SubmitProposalService.new(@proposal, params).save_answers
    @publish = true
   	redirect_to edit_proposal_path(@proposal, publish: @publish)
  end

  private
  
  def proposal_params
    params.permit(:title, :year, :subject_id, ams_subject_ids: [])
  end
end
