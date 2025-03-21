FactoryBot.define do
  factory :job_listing do
    title { Faker::Job.title }
    description { Faker::Lorem.paragraphs(number: 3).join("\n\n") }
    url { Faker::Internet.url }
    association :company
    remote { [true, false].sample }
    salary_min { rand(30000..50000) }
    salary_max { rand(51000..100000) }
    currency { "EUR" }
    contract_type { JobListing.contract_types.keys.sample }
  end
end
