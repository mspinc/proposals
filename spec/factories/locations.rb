FactoryBot.define do
  factory :location do
    city { Faker::Address.city }
    country { Faker::Address.country }
    code { ('A'..'Z').to_a.sample(4).join }
    name { Faker::University.name }
  end
end
