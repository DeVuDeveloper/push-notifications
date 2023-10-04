class PushSubscription < ApplicationRecord
  validates :endpoint, presence: true
  validates :p256dh, presence: true
  validates :auth, presence: true
end
