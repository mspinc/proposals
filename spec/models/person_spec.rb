require 'rails_helper'

RSpec.describe Person, type: :model do
  it 'has valid factory' do
    expect(build(:person)).to be_valid
  end

  it 'requires a firstname' do
    p = build(:person, first_name: '')
    expect(p.valid?).to be_falsey
  end

  it 'requires a lastname' do
    p = build(:person, last_name: '')
    expect(p.valid?).to be_falsey
  end

  it "requires an email" do
    p = build(:person, email: '')
    expect(p.valid?).to be_falsey
  end
end
