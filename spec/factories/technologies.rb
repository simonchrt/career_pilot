FactoryBot.define do
  factory :technology do
    name { Faker::ProgrammingLanguage.name }
    category { Technology.categories.keys.sample }
  end
end
