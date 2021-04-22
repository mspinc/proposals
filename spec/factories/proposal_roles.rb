FactoryBot.define do
  factory :proposal_role do
    association :role, factory: :role, strategy: :create
    association :proposal, factory: :proposal, strategy: :create
  end
end
