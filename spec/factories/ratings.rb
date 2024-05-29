FactoryBot.define do
  factory :rating do
    association :user, factory: :user
    association :movie, factory: :movie
    score { Faker::Number.between(from: 1, to: 10) } # Use Faker to generate a random score
  end
end
