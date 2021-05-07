FactoryBot.define do
  factory :proposal_fields_multi_choice, class: 'ProposalFields::MultiChoice' do
    statement { Faker::Lorem.paragraph }
    options do
      { "0" => { "text" => "Male", "index" => "0", "value" => "M" },
        "1" => { "text" => "Female", "index" => "1", "value" => "F" } }
    end
  end
end
