require 'rails_helper'

RSpec.feature "Proposal Form show", type: :feature do
  before do
    @proposal_form = create(:proposal_form)
    visit proposal_form_path(@proposal_form)
  end

  it "shows the published status of the proposal " do
    expect(find_by_id('proposal_status').text).to eq(@proposal_form.status)
  end

  it 'shows created by information' do
    expect(page).to have_text(@proposal_form.created_by.fullname)
    expect(page).to have_text(@proposal_form.created_on)
  end


  it 'does not show updated information if it is the same as created' do
    expect(@proposal_form.created_at).to eq(@proposal_form.updated_at)
    expect(page).not_to have_text('Updated on')
  end

  it 'shows updated information if it is greater than created' do
    @proposal_form.title = 'New title'
    @proposal_form.save

    visit proposal_form_path(@proposal_form)

    expect(page).to have_text(@proposal_form.updated_on)
    expect(page).to have_text(@proposal_form.updated_by.fullname)
  end

  it 'displays the title and introduction' do
    expect(page).to have_text(@proposal_form.title)
    expect(page).to have_text(@proposal_form.introduction)
  end

  it 'diplays the form fields'

  it 'has a link to edit the draft proposal form' do
    @proposal_form.status = 'draft'
    @proposal_form.save

    visit proposal_form_path(@proposal_form)

    expect(page).to have_link('Edit Proposal Form', href: edit_proposal_form_path(@proposal_form))
  end

  it 'has no link to edit active proposal forms' do
    @proposal_form.status = 'active'
    @proposal_form.save

    visit proposal_form_path(@proposal_form)

    expect(page).not_to have_link('Edit Proposal Form')
  end
end
