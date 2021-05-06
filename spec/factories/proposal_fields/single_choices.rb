FactoryBot.define do
  factory :proposal_fields_single_choice, class: 'ProposalFields::SingleChoice' do
    statement { Faker::Lorem.paragraph }
    options do
      { "0" => { "text" => "Male", "index" => "0", "value" => "M" },
        "1" => { "text" => "Female", "index" => "1", "value" => "F" } }
    end
  end
end
