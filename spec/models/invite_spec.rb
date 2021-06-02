require 'rails_helper'

RSpec.describe Invite, type: :model do
  describe 'validations' do
    it 'has valid factory' do
      expect(build(:invite)).to be_valid
    end

    it 'requires a firstname' do
      invite = build(:invite, firstname: '')
      expect(invite.valid?).to be_falsey
    end

    it 'requires a lastname' do
      invite = build(:invite, lastname: '')
      expect(invite.valid?).to be_falsey
    end

    it "requires an email" do
      invite = build(:invite, email: '')
      expect(invite.valid?).to be_falsey
    end

    it "requires an invite as" do
      invite = build(:invite, invited_as: '')
      expect(invite.valid?).to be_falsey
    end
  end

  describe 'associations' do
    it { should belong_to(:proposal) }
    it { should belong_to(:person) }
  end
end
