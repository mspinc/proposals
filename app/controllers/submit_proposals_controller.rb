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
      flash[:alert] = 'There are some errors, please see form.' if params[:commit] == 'Submit Proposal'
      redirect_to edit_proposal_path(@proposal, publish: @publish)
    end
  end

  def thanks; end

  private

  def proposal_params
    params.permit(:title, :year, :subject_id).merge(ams_subject_ids: proposal_ams_subjects)
  end

  def proposal_ams_subjects
    @code1 = params.dig(:ams_subjects, :code1)
    @code2 = params.dig(:ams_subjects, :code2)
    [@code1, @code2]
  end

  def update_ams_subject_code
    @proposal.ams_subjects.where(id: @code1)&.update(code: 'code1')
    @proposal.ams_subjects.where(id: @code2)&.update(code: 'code2')
  end
end
