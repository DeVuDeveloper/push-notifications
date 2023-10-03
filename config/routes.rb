Rails.application.routes.draw do
  devise_for :users, path: 'account', path_names: {
    sign_in: 'login',
    sign_out: 'logout',
    password: 'reset_password',
    registration: 'register'
  }

  root 'home#index'

  get "/verify" => "verify#edit", :as => "verify"
  get "/verify" => "verify#new", :as => "new_verify"
  put "/verify" => "verify#update", :as => "update_verify"
  post "/verify" => "verify#create", :as => "resend_verify"
end
