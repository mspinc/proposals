require 'rails_helper'

RSpec.feature "Locations show", type: :feature do
  # @scenario "Locations#show feature tests..."

  before do
    @location = create(:location)
    visit location_path(@location)
  end

  scenario "there is a Name field containing the name" do
    expect(find_by_id('location_name').text).to eq(@location.name)
  end

  scenario "there is a Code field containing the code" do
    expect(find_by_id('location_code').text).to eq(@location.code)
  end

  scenario "there is a City field containing the city" do
    expect(find_by_id('location_city').text).to eq(@location.city)
  end

  scenario "there is a Country field containing the country" do
    expect(find_by_id('location_country').text).to eq(@location.country)
  end

  scenario "click on edit" do
    expect(page).to have_link(href: edit_location_path(@location))
  end

  scenario "click on back" do
    expect(page).to have_link(href: locations_path)
  end
end
