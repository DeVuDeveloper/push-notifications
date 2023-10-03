require 'rails_helper'

RSpec.describe VerifyController, type: :controller do
  let(:user) { create(:user) }

  before { sign_in user }

  describe 'POST #create' do
    it 'sends a verification code to the user email' do
      create(:user)
      post :create
      expect(response).to redirect_to verify_url
      expect(flash[:notice]).to eq("Verification code has been sent to email address.")
    end
  end

  describe 'GET #edit' do
    it 'renders the edit template' do
      get :edit
      expect(response).to render_template :edit
    end
  end

  describe 'PUT #update' do
    context 'when the pin has expired' do
      it 'renders the new template with an alert' do
        user.update(pin_sent_at: 2.hours.ago)
        put :update, params: { user: { pin_0: '1', pin_1: '2', pin_2: '3', pin_3: '4' } }
        expect(flash[:alert]).to eq("Your pin has expired. Please request another.")
      end
    end

    context 'when the pin is valid' do
      it 'marks the email as verified and redirects to root_url' do
        user.update(pin: '1234')
        put :update, params: { user: { pin_0: '1', pin_1: '2', pin_2: '3', pin_3: '4' } }
        user.reload
        expect(user.verified).to be_truthy
        expect(response).to redirect_to root_url
        expect(flash[:notice]).to eq("Your email address has been verified!")
      end
    end

    context 'when the pin is invalid' do
      it 'renders the edit template with an alert' do
        user.update(pin: '1234')
        put :update, params: { user: { pin_0: '5', pin_1: '6', pin_2: '7', pin_3: '8' } }
        expect(response).to render_template :edit
        expect(flash[:alert]).to eq("The code you entered is invalid.")
      end
    end
  end
end
