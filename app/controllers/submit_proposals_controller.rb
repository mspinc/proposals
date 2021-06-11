class SubmitProposalsController < ApplicationController
  def new
    @proposals = ProposalForm.new
  end

  def create
    @proposal = Proposal.find params[:proposal]
    @proposal.update(proposal_params)
    update_ams_subject_code
    
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
    params.permit(:title, :year, :subject_id, :ams_subject_ids, :location_ids) #.merge(ams_subject_ids: proposal_ams_subjects)
  end

  def proposal_ams_subjects
    ams_subjects = proposal_params[:ams_subject_ids]
    [ams_subjects.first, ams_subjects.last]
  end

  def update_ams_subject_code
    @proposal.ams_subjects.where(id: @param[:code1])&.update(code: 'code1')
    @proposal.ams_subjects.where(id: @param[:code2])&.update(code: 'code2')
  end

end
