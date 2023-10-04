class ApplicationController < ActionController::Base
  before_action :configure_permitted_parameters, if: :devise_controller?
  protect_from_forgery
  before_action :redirect_if_unverified

  def redirect_if_unverified
    return unless signed_in? && !current_user.verified?

    redirect_to verify_path, notice: "Please verify your email address"
  end

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up) do |u|
      u.permit(:email, :phone, :password, :password_confirmation, :verified)
    end
    devise_parameter_sanitizer.permit(:sign_in) do |u|
      u.permit(:email, :phone, :password, :password_confirmation, :verified)
    end
    devise_parameter_sanitizer.permit(:account_update) do |u|
      u.permit(:email, :phone, :password, :password_confirmation, :verified)
    end
  end
end
