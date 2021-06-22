class PeopleController < ApplicationController
  before_action :set_person
  layout('devise')

  def new
    @invited_as = invite&.invited_as
    @proposal = invite&.proposal

    redirect_to root_path, alert: 'Something went wrong.' unless @person
  end

  def update
    if @person.update(person_params)
      redirect_to new_survey_path(code: params[:code]), notice: "Thank you!"
    elsif invited_person.present?
      redirect_to new_person_path(code: params[:code]), alert: @person.errors.full_messages
    else
      redirect_to new_person_path, alert: @person.errors.full_messages
    end
  end

  private

  def person_params
    params.require(:person).permit(:affiliation, :department, :academic_status,
                                   :title, :first_phd_year, :country, :region,
                                   :city, :street_1, :street_2, :postal_code,
                                   :other_academic_status, :province, :state)
  end

  def set_person
    @person = invited_person || current_user&.person
    @person.is_lead_organizer = true if params[:code].blank?
  end

  def invite
    Invite.find_by(code: params[:code])
  end

  def invited_person
    invite&.person
  end
end
