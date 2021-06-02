require 'rails_helper'

RSpec.describe Proposal, type: :model do
  describe 'validations' do
    it 'has valid factory' do
      expect(build(:proposal)).to be_valid
    end
  end

  describe 'associations' do
    it { should have_many(:proposal_locations).dependent(:destroy) }
    it { should have_many(:locations).through(:proposal_locations) }
    it { should belong_to(:proposal_type) }
    it { should have_many(:proposal_roles).dependent(:destroy) }
    it { should have_many(:people).through(:proposal_roles) }
  end

  describe '#lead_organizer' do
    let(:proposal) { create(:proposal) }
    let(:proposal_roles) { create_list(:proposal_role, 3, proposal: proposal)}
    before do
      proposal_roles.last.role.update(name: 'lead_organizer')
    end
    it 'returns person who is lead_organizer in proposal' do 
      expect(proposal.lead_organizer).to eq(proposal.people.last)
    end
  end
end
