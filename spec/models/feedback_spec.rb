require 'rails_helper'

RSpec.describe Feedback, type: :model do
  describe 'validations' do
    it 'has valid factory' do
      expect(build(:feedback)).to be_valid
    end

    describe 'associations' do
      it { should belong_to(:user) }
    end
  end
end
