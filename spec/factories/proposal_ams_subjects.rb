FactoryBot.define do
  factory :proposal_ams_subject do
    association :proposal, factory: :proposal, strategy: :create
    association :ams_subject, factory: :ams_subject, strategy: :create
  end
end
