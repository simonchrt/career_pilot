FactoryBot.define do
  factory :application do
    association :user
    association :job_listing
    status { Application.statuses.keys.sample }
    applied_date { Faker::Date.backward(days: 30) }


    response_date { |n| n.applied_date ? Faker::Date.between(from: n.applied_date, to: Date.today) : nil }

    interview_date { Faker::Date.forward(days: 14) }
    notes { Faker::Lorem.paragraph }
    priority { rand(1..5) }
  end
end
