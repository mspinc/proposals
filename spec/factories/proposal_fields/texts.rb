FactoryBot.define do
  factory :proposal_fields_text, class: 'ProposalFields::Text' do
    statement { Faker::Lorem.paragraph }
  end
end
