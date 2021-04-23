require 'rails_helper'

RSpec.describe ProposalRole, type: :model do
  describe 'validations' do
    it 'has valid factory' do
      expect(build(:proposal_role)).to be_valid
    end
  end

  describe 'associations' do
    it { should belong_to(:role) }
    it { should belong_to(:proposal) }
  end
end
