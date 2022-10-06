FactoryBot.define do
  factory :comment do
    body { Faker::Lorem.sentence }
    article_id { Faker::Number.number(2) }
    user_id { Faker::Number.number(2) }
  end
end