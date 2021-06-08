require 'factory_bot_rails'

FactoryBot.define do
  factory :invite do |f|
    f.firstname
    f.lastname
    f.email
    
    invited_as { %w[participant coorganizer]}
    status { %w[pending completed].sample }
    response { %w[yes maybe no].sample }
    code { SecureRandom.urlsafe_base64(37) }
    association :proposal, factory: :proposal, strategy: :create
    association :person, factory: :person
  end
end
