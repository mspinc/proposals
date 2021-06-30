class ProfileController < ApplicationController
	def editProfile
		@person = current_user&.person
    @person.is_lead_organizer = true if @person.city
	end

	 def update
		@person = current_user&.person
    if @person.update(person_params)
      redirect_to profile_path, notice: "Thank you!"
    else
      redirect_to profile_path
    end
  end

  private

  def person_params
    params.require(:person).permit(:affiliation, :department, :academic_status,
                                   :title, :first_phd_year, :country, :region,
                                   :city, :street_1, :street_2, :postal_code,
                                   :other_academic_status, :province, :state)
  end
end
