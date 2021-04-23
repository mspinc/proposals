require 'rails_helper'

RSpec.describe Proposal, type: :model do
  describe 'validations' do
    it 'has valid factory' do
      expect(build(:proposal)).to be_valid
    end
  end

  describe 'associations' do
    it { should have_many(:locations).through(:proposal_locations) }
    it { should have_many(:people).through(:proposal_roles) }
    it { should belong_to(:proposal_type) }
  end
end
