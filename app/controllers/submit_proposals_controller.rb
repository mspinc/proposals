class SubmitProposalsController < ApplicationController
  def new
    @proposals = ProposalForm.new
  end

  def create
    @proposal = Proposal.find params[:proposal]
    @proposal.update(proposal_params)
    update_ams_subject_code
    
    session[:is_submission] = params[:commit] == 'Submit Proposal'
    submission = SubmitProposalService.new(@proposal, params)
    submission.save_answers

    if submission.errors.empty?
      redirect_to thanks_submit_proposals_path, notice: 'Your proposal has been
            submitted. A copy of your proposal has been emailed to you.'.squish
    else
      redirect_to edit_proposal_path(@proposal), flash_notice(submission)
    end
  end

  def thanks; end

  private

  def proposal_params
    params.permit(:title, :year, :subject_id, :ams_subject_ids, :location_ids)
          .merge(ams_subject_ids: proposal_ams_subjects)
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

  def flash_notice(submission)
    if params[:commit] == 'Submit Proposal'
      { alert: "Your submission has errors: #{submission.errors.join(', ')}" }
    else
      { notice: 'Draft saved.' }
    end
  end
end
