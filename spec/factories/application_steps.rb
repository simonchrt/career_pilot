FactoryBot.define do
  factory :application_step do
    association :application
    step_type { ApplicationStep.step_types.keys.sample }
    date { Faker::Date.between(from: 30.days.ago, to: Date.today) }
    notes { Faker::Lorem.paragraph }
    completed { [true, false].sample }
    next_action_date { Faker::Date.forward(days: 14) }
  end
end
