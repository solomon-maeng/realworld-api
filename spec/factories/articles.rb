FactoryBot.define do
  factory :article do
    title { Faker::Lorem.word }
    body { Faker::Lorem.sentences }
    description { Faker::Lorem.sentence }
    slug { Faker::Lorem.word }
    user_id { Faker::Number.number(2) }
  end
end