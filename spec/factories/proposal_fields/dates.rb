FactoryBot.define do
  factory :proposal_fields_dates, class: 'ProposalFields::Date' do
    statement { Faker::Lorem.paragraph }
  end
end
