FactoryBot.define do
  factory :location do
    city { Faker::Address.city }
    country { Faker::Address.country }
    code { ('A'..'Z').to_a.shuffle[0,4].join }
    name { Faker::University.name }
  end
end
