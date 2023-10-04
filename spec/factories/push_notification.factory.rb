FactoryBot.define do
  factory :push_notification do
    title { Faker::Lorem.sentence }
    body { Faker::Lorem.paragraph }
  end
end
