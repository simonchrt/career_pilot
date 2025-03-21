FactoryBot.define do
  factory :job_technology do
    association :job_listing
    association :technology
  end
end
