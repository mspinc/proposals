# spec/factories/people.rb
require 'factory_bot_rails'
require 'faker'

FactoryBot.define do
  sequence(:first_name) { |n| "#{n}-#{Faker::Name.first_name}" }
  sequence(:last_name) { Faker::Name.last_name }
  sequence(:email) { |n| "person-#{n}@" + Faker::Internet.domain_name }

  factory :person do |f|
    f.first_name
    f.last_name
    f.email
    f.affiliation { Faker::University.name }
    #f.url { Faker::Internet.url }
    # f.areas_of_expertise { Faker::Lorem.words(4).join(', ') }
    f.biography { Faker::Lorem.paragraph }
    f.retired { %w[true false].sample }
    f.deceased { %w[true false].sample }
  end
end
