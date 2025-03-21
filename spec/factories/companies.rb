FactoryBot.define do
  factory :company do
    name { Faker::Company.name }
    website { Faker::Internet.url }
    industry { Faker::Company.industry }
    location { Faker::Address.city }
    size { %w[startup small medium large enterprise].sample }
    notes { Faker::Lorem.paragraph }
  end
end
