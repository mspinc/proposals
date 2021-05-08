require 'rails_helper'

RSpec.feature "Locations index", type: :feature do
  before do
    3.times { create(:location) }
    visit locations_path
  end

  scenario "lists existing locations" do
    Location.all.each do |location|
      expect(page).to have_text(location.name)
    end
  end

  scenario "there are a links to location#show" do
    Location.all.each do |location|
      expect(page).to have_link(href: location_path(location))
    end
  end

  scenario "there is a link to location#edit" do
    Location.all.each do |location|
      expect(page).to have_link(href: edit_location_path(location))
    end
  end

  scenario "there is a link to location#destroy" do
    Location.all.each do |location|
      del_link = "a[href='#{location_path(location)}'][data-method='delete']"
      expect(page).to have_selector(del_link)
    end
  end

  scenario "there is a link to create a new location" do
    expect(page).to have_link(href: new_location_path)
  end
end
