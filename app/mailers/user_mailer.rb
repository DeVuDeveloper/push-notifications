class UserMailer < ApplicationMailer
  def send_pin(user)
    @user = user
    mail(to: @user.email, subject: 'Verification PIN Code')
  end
end
