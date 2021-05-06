require 'rails_helper'

RSpec.describe ProposalForm, type: :model do
  describe 'validations' do
    it 'has valid factory' do
      expect(build(:proposal_form)).to be_valid
    end
  end

  describe 'with active status' do
    let(:proposal_form) { create(:proposal_form, status: :active) }
    it { expect(proposal_form.status).to eq('active') }
  end

  describe 'with draft status' do
    let(:proposal_form) { create(:proposal_form, status: :draft) }
    it { expect(proposal_form.status).to eq('draft') }
  end

  describe 'associations' do
    it { should belong_to(:proposal_type) }
    it { should have_many(:proposal_fields) }
  end
end
