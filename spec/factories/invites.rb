require 'factory_bot_rails'

FactoryBot.define do
  factory :invite do |f|
    f.firstname
    f.lastname
    f.email
    
    invited_as { %w[participant coorganizer]}
    status { %w[pending completed].sample }
    response { %w[yes maybe no].sample }
    deadline_date { Time.current.to_date }

    association :proposal, factory: :proposal, strategy: :create
    association :person, factory: :person
  end
end
