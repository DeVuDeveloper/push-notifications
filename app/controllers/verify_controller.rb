class VerifyController < ApplicationController
  skip_before_action :redirect_if_unverified

  def create
    current_user.send_pin!
    redirect_to verify_url, notice: "Verification code has been sent to email address."
  end

  def edit
    @user = current_user
  end

  def update
    code = "#{params[:user][:pin_0]}#{params[:user][:pin_1]}#{params[:user][:pin_2]}#{params[:user][:pin_3]}"
    @user = current_user
    if Time.now > current_user.pin_sent_at.advance(minutes: 60)
      flash.now[:alert] = "Your pin has expired. Please request another."
      render :edit and return
    elsif code.try(:to_i) == current_user.pin
      current_user.update_attribute(:verified, true)
      redirect_to root_url, notice: "Your email address has been verified!"
    else
      flash.now[:alert] = "The code you entered is invalid."
      render :edit
    end
  end
end
