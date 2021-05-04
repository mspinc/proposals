require 'rails_helper'

RSpec.feature "Locations edit", type: :feature do
  before do
    @location = create(:location)
    visit edit_location_path(@location)
  end

  scenario "there is a Name field containing the name" do
    expect(find_field('Name').value).to eq(@location.name)
  end

  scenario "there is a Code field containing the code" do
    expect(find_field('Code').value).to eq(@location.code)
  end

  scenario "there is a City field containing the city" do
    expect(find_field('City').value).to eq(@location.city)
  end

  scenario "there is a Country field containing the country" do
    expect(find_field('Country').value).to eq(@location.country)
  end

  scenario "updating the form fields updates the data" do
    fill_in 'Name', with: 'New Name'
    fill_in 'Code', with: 'NN'
    fill_in 'City', with: 'New City'
    fill_in 'Country', with: 'New Country'

    click_button 'Update Location'

    expect(page).to have_text('Location was successfully updated')
    updated_location = Location.find(@location.id)
    expect(updated_location.name).to eq('New Name')
    expect(updated_location.code).to eq('NN')
    expect(updated_location.city).to eq('New City')
    expect(updated_location.country).to eq('New Country')
  end
end
