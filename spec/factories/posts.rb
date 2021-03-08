FactoryBot.define do
  factory :post do
    title { Faker::Lorem.sentence }
    youtube_url { 'https://www.youtube.com/watch?v=4nTTWcHD-D8&t=6344s' }
    text { Faker::Lorem.sentence }
    association :user
  end
end
