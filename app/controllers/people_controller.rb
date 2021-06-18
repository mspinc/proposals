class PeopleController < ApplicationController
  before_action :set_person
  layout('devise')

  def new
    @invited_as = invite&.invited_as

    redirect_to root_path, alert: 'Something went wrong.' unless @person
  end

  def update
    if @person.update(person_params)
      redirect_to new_survey_path, notice: "Personal data saved successfully"
    else
      redirect_to new_person_path, alert: "There is some issue with your data"
    end
  end

  private

  def person_params
    params.require(:person).permit(:affiliation, :department, :title, :academic_status, :year_first_phd, :country,
                                   :province, :state, :city, :street_1, :street_2, :address)
  end

  def set_person
    @person = current_user&.person || invited_person
  end

  def invite
    Invite.find_by(code: params[:code])
  end

  def invited_person
    invite&.person
  end
end
