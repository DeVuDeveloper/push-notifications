FactoryBot.define do
  factory :push_subscription do
    endpoint { Faker::Internet.url }
    p256dh { Faker::Crypto.sha256 }
    auth { Faker::Crypto.sha256 }
    subscribed { true }
  end
end
