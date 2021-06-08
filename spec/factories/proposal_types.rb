FactoryBot.define do
  factory :proposal_type do
    name { '5 Day Workshop' }
    year { '2021,2022,2023' }
    participant { 2 }
    co_organizer { 3 }
  end
end
