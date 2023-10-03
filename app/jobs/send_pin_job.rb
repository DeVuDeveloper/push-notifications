class SendPinJob < ApplicationJob
  queue_as :default

  def perform(user)
    user.reset_pin!
    user.update(pin_sent_at: Time.now)
    UserMailer.send_pin(user).deliver_now
  end
end
