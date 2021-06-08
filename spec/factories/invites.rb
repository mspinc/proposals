require 'factory_bot_rails'

FactoryBot.define do
  factory :invite do |f|
    f.firstname
    f.lastname
    f.email
    
    invited_as { %w[participant coorganizer]}
    status { %w[pending completed].sample }
    response { %w[yes maybe no].sample }
<<<<<<< HEAD
    deadline_date { Time.current.to_date }

=======
    code { SecureRandom.urlsafe_base64(37) }
>>>>>>> a1033a19c38f0b2bdab9ab0f646ab21be97c3d01
    association :proposal, factory: :proposal, strategy: :create
    association :person, factory: :person
  end
end
