require 'factory_bot_rails'
require 'faker'

FactoryBot.define do
  factory :invite do |f|
    f.firstname
    f.lastname
    f.email
    f.invited_as

    status { %w[pending completed].sample }
    response { %w[yes maybe not].sample }
    association :proposal, factory: :proposal, strategy: :create
    association :person, factory: :person
  end
end
