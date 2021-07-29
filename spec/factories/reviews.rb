FactoryBot.define do
  factory :review do
    rate { 1 }
    body { Faker::Lorem.characters(number: 20) }
    date {'2021/07/01'}
    place { Faker::Lorem.characters(number: 10) }
    association :user
    association :stage
  end
end
