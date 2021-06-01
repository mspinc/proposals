class SurveyController < ApplicationController
  layout('devise')

  def new
    @survey = Survey.first
  end

  def survey_questionnaire; end

  def submit_survey
    demographic_data = DemographicData.new
    demographic_data.result = questionnaire_answers
    if demographic_data.save
      redirect_to survey_questionnaire_survey_index_path, notice: 'Survey Questionnaire was successfully submitted'
    else
      redirect_to survey_questionnaire_survey_index_path, error: 'Error submittingsurvey questionnaire'
    end
  end

  private

  def questionnaire_answers
    params.require(:survey)
  end
end
