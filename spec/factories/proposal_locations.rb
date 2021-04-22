FactoryBot.define do
  factory :proposal_location do
    association :location, factory: :location, strategy: :create
    association :proposal, factory: :proposal, strategy: :create
  end
end
