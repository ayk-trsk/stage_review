FactoryBot.define do
  factory :bookmark do
    association :user
    association :stage
  end
end
