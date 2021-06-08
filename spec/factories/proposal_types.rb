FactoryBot.define do
  factory :proposal_type do
    name { '5 Day Workshop' }
    participant { 2 }
    co_organizer { 3 }
  end
end
