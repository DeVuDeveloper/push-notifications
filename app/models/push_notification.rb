class PushNotification < ApplicationRecord
  validates :title, presence: true
  validates :body, presence: true

  after_create_commit lambda {
                        broadcast_prepend_to "push_notifications", partial: "admin/push_notifications/push_notification",
                                                                   locals: { push_notification: self }, target: "push_notifications"
                      }
end
