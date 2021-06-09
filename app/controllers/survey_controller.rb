class SurveyController < ApplicationController
  before_action :set_invite, only: %i[submit_survey]
  layout('devise')

  def new
    @survey = Survey.first
  end

  def survey_questionnaire; end

  def submit_survey
    demographic_data = DemographicData.new
    demographic_data.result = questionnaire_answers
    demographic_data.person = @invite.person
    if demographic_data.save
      redirect_to thanks_proposal_invites_path(@invite.proposal), notice: 'Questionnaire was successfully submitted'
    else
      redirect_to survey_questionnaire_survey_index_path(id: @invite.id), alert: demographic_data.errors.full_messages.join(', ')
    end
  end

  private

  def questionnaire_answers
    params.require(:survey)
  end

  def set_invite
    @invite = Invite.find_by(code: invite_code)
  end

  def invite_code
    params.permit([:code])&.[](:code)
  end
end
