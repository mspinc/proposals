FactoryBot.define do
  factory :feedback do
    content { Faker::Lorem.paragraph(sentence_count: 5) }
    association :user, factory: :user, strategy: :create
  end
end
