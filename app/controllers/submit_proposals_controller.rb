class SubmitProposalsController < ApplicationController
  before_action :set_proposal, only: %i[create]
  def new
    @proposals = ProposalForm.new
  end

  def create
    @proposal.update(proposal_params)
    update_ams_subject_code
    
    draft_or_final = params[:commit] == 'Submit Proposal'
    session[:is_submission] = @proposal.is_submission = draft_or_final

    submission = SubmitProposalService.new(@proposal, params)
    submission.save_answers

    if submission.errors.flatten.empty?
      session[:is_submission] = nil

      ProposalMailer.with(proposal: @proposal, file: proposal_pdf, email: current_user.email).proposal_submission.deliver_later
      redirect_to thanks_submit_proposals_path, notice: 'Your proposal has been
            submitted. A copy of your proposal has been emailed to you.'.squish
    else
      redirect_to edit_proposal_path(@proposal), flash_notice(submission)
    end
  end

  def thanks; end

  private

  def proposal_pdf
    ProposalPdfService.new(@proposal.id, session[:latex_file], 'all').pdf
    fh = File.open("#{Rails.root}/tmp/#{session[:latex_file]}")
    render_to_string(layout: "application", inline: "#{fh.read}", formats: [:pdf])
  end

  def proposal_params
    params.permit(:title, :year, :subject_id, :ams_subject_ids, :location_ids)
          .merge(ams_subject_ids: proposal_ams_subjects)
  end

  def set_proposal
    @proposal = Proposal.find(params[:proposal])
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
    if @proposal.is_submission
      { alert: "Your submission has errors: #{submission.errors.flatten.join(', ')}" }
    else
      { notice: 'Draft saved.' }
    end
  end
end
