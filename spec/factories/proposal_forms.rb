FactoryBot.define do
  factory :proposal_form do
    status { %w[draft active].sample }

    association :proposal_type, factory: :proposal_type, strategy: :create
    association :created_by, factory: :user, strategy: :create
    association :updated_by, factory: :user, strategy: :create
  end
end
