FactoryBot.define do
  factory :stage do
    name { Faker::Lorem.characters(number: 10) }
    genre_id { FactoryBot.create(:genre).id }
    start_date { '2021/07/01' }
    end_date { '2021/07/31' }
  end
end
