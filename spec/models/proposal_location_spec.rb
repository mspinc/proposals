require 'rails_helper'

RSpec.describe ProposalLocation, type: :model do
  describe 'validations' do
    it 'has valid factory' do
      expect(build(:proposal_location)).to be_valid
    end
  end

  describe 'associations' do
    it { should belong_to(:proposal) }
    it { should belong_to(:location) }
  end
end
