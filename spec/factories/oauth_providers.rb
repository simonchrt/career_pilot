FactoryBot.define do
  factory :oauth_provider do
    association :user
    provider { %w[github linkedin].sample }
    uid { Faker::Internet.uuid }
  end

  trait :github do
    provider { 'github' }
  end

  trait :linkedin do
    provider { 'linkedin' }
  end
end
