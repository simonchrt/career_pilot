FactoryBot.define do
  factory :user do
    first_name { Faker::Name.first_name }
    last_name { Faker::Name.last_name }
    username { Faker::Internet.username }
    email { Faker::Internet.email }
    password { 'password123' }
    password_confirmation { 'password123' }
    profile_completed { false }
    admin { false }

    trait :admin do
      admin { true }
    end

    trait :with_profile do
      profile_completed { true }
    end
  end
end
