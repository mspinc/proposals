require 'rails_helper'

RSpec.feature "Proposal_Form index", type: :feature do
  before do
    3.times { create(:proposal_form) }
    visit proposal_forms_path
  end

  scenario "list all existing proposal Forms" do
    ProposalForm.all.each do |proposal_form|
      expect(page).to have_text(proposal_form.proposal_type.name)
      proposal_form.proposal_type.locations.each do |loc|
        expect(page).to have_text(loc.name)
      end

      expect(page).to have_text(proposal_form.status)
      expect(page).to have_text(proposal_form.created_at.to_date)
      expect(page).to have_text(proposal_form.created_by.email)
      expect(page).to have_text(proposal_form.updated_by.email)
    end
  end

  scenario "there is a link to proposal_form_#show" do
    ProposalForm.all.each do |proposal_form|
      expect(page).to have_link(href: proposal_form_path(proposal_form))
    end
  end

  scenario "there is a link to ProposalForm#destroy" do
    ProposalForm.all.each do |proposal_form|
      del_link = "a[href='#{proposal_form_path(proposal_form)}'][data-method='delete']"
      expect(page).to have_selector(del_link)
    end
  end

  scenario "there is a link to proposal_form_#edit" do
    ProposalForm.all.each do |proposal_form|
      expect(page).to have_link(href: edit_proposal_form_path(proposal_form)) if proposal_form.status == 'draft'
    end
  end
end
