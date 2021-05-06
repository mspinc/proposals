require 'rails_helper'

RSpec.describe ProposalField, type: :model do
  describe 'validations' do
    it 'has valid factory' do
      expect(build(:proposal_field, :radio_field)).to be_valid
    end
  end

  describe 'associations' do
    it { should belong_to(:proposal_form) }
  end
end
