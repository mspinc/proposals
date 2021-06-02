require 'rails_helper'

RSpec.describe Person, type: :model do
  describe 'validations' do
    it 'has valid factory' do
      expect(build(:person)).to be_valid
    end

    it 'requires a firstname' do
      p = build(:person, firstname: '')
      expect(p.valid?).to be_falsey
    end

    it 'requires a lastname' do
      p = build(:person, lastname: '')
      expect(p.valid?).to be_falsey
    end

    it "requires an email" do
      p = build(:person, email: '')
      expect(p.valid?).to be_falsey
    end
  end

  describe 'associations' do
    it { should belong_to(:user).optional(true) }
    it { should have_many(:proposals).through(:proposal_roles) }
  end

  describe '#fullname' do
    let(:person) { create(:person) }
    let(:fullname) { person.firstname + ' ' + person.lastname }
    it 'returns fullname of person' do
      expect(person.fullname).to eq(fullname)
    end
  end
end
