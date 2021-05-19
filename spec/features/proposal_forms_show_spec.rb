require 'rails_helper'

RSpec.feature "Proposal Form show", type: :feature do

before do
    @proposal_form = create(:proposal_form)
    visit proposal_form_path(@proposal_form)
  end

  scenario "there is a label for status of the proposal " do
    expect(find_by_id('proposal_status').text).to eq(@proposal_form.status)
  end
end
