class SubmitProposalsController < ApplicationController
  before_action :set_proposal, only: %i[create]
  def new
    @proposals = ProposalForm.new
  end

  def create
    if @proposal.update(proposal_params)
      update_ams_subject_code
      submission = SubmitProposalService.new(@proposal, params)
      submission.save_answers
      session[:is_submission] = @proposal.is_submission = submission.is_final?

      unless @proposal.is_submission
        redirect_to edit_proposal_path(@proposal), 'Draft saved.'
        return
       end

      if submission.has_errors?
        redirect_to edit_proposal_path(@proposal), alert: "Your submission has
            errors: #{submission.error_messages}.".squish
        return
      end

      attachment = generate_proposal_pdf || return
      confirm_submission(attachment)
    else
      if request.xhr?
        render json: @proposal.errors.full_messages, status: 422
      else
        redirect_to edit_proposal_path(@proposal), alert: @proposal.errors.full_messages
      end
    end
  end

  def thanks; end

  private

  def confirm_submission(attachment)
    @proposal.update(status: :active)
    session[:is_submission] = nil

    ProposalMailer.with(proposal: @proposal, file: attachment)
                  .proposal_submission.deliver_later

    redirect_to thanks_submit_proposals_path, notice: 'Your proposal has
        been submitted. A copy of your proposal has been emailed to
        you.'.squish
  end

  def generate_proposal_pdf
    temp_file = "propfile-#{current_user.id}-#{@proposal.id}.tex"
    ProposalPdfService.new(@proposal.id, temp_file, 'all').pdf
    fh = File.open("#{Rails.root}/tmp/#{temp_file}")

    begin
      render_to_string(layout: "application", inline: "#{fh.read}",
                       formats: [:pdf])
    rescue ActionView::Template::Error => error
      flash[:alert] = "We were unable to compile your proposal with LaTeX.
                      Please see the error messages, and generated LaTeX
                      docmument, then edit your submission to fix the
                      errors".squish

      error_output = ProposalPdfService.format_errors(error)
      render layout: "latex_errors", inline: "#{error_output}", formats: [:html]
      return
    end
  end

  def proposal_params
    params.permit(:title, :year, :subject_id, :ams_subject_ids, :location_ids, :no_latex,
                  invites_attributes: %i[id firstname lastname email deadline_date invited_as _destroy])
          .merge(ams_subject_ids: proposal_ams_subjects)
  end

  def proposal_id_param
    params.permit(:proposal)['proposal'].to_i
  end

  def set_proposal
    @proposal = Proposal.find(proposal_id_param)
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
