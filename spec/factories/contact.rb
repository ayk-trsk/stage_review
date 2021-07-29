FactoryBot.define do
  factory :contact do
    email { Faker::Internet.email }
    subject { Faker::Lorem.characters(number: 10) }
    message { Faker::Lorem.characters(number: 50) }
  end
end
