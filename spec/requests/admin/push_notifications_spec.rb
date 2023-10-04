RSpec.describe 'Admin::PushNotificationsController', type: :request do
  let(:user) { FactoryBot.create(:user, role: 1) }

  before do
    user.update(verified: true)
    post user_session_path, params: { user: { email: user.email, password: user.password } }
  end

  describe 'GET /admin/push_notifications' do
    it 'returns a successful response' do
      get admin_push_notifications_path
      expect(response).to have_http_status(:ok)
    end
  end

  describe 'GET /admin/push_notifications/:id' do
    let(:push_notification) { FactoryBot.create(:push_notification) }

    it 'returns a successful response' do
      get admin_push_notification_path(push_notification)
      expect(response).to have_http_status(:ok)
    end
  end

  describe 'GET /admin/push_notifications/new' do
    it 'returns a successful response' do
      get new_admin_push_notification_path
      expect(response).to have_http_status(:ok)
    end
  end

  describe 'POST /admin/push_notifications' do
    let(:valid_attributes) { FactoryBot.attributes_for(:push_notification) }

    context 'with valid attributes' do
      it 'creates a new push notification' do
        expect do
          post admin_push_notifications_path, params: { push_notification: valid_attributes }
        end.to change(PushNotification, :count).by(1)
      end

      it 'redirects to the index page' do
        post admin_push_notifications_path, params: { push_notification: valid_attributes }
        expect(response).to redirect_to(admin_push_notifications_path)
      end
    end

    context 'with invalid attributes' do
      it 'does not create a new push notification' do
        expect do
          post admin_push_notifications_path, params: { push_notification: { title: nil, body: nil } }
        end.not_to change(PushNotification, :count)
      end

      it 'renders the new template' do
        post admin_push_notifications_path, params: { push_notification: { title: nil, body: nil } }
        expect(response).to render_template(:new)
      end
    end
  end

  describe 'DELETE /admin/push_notifications/:id' do
    let(:push_notification) { FactoryBot.create(:push_notification) }

    it 'destroys the push notification' do
      push_notification
      expect do
        delete admin_push_notification_path(push_notification)
      end.to change(PushNotification, :count).by(-1)
    end

    it 'redirects to the index page' do
      delete admin_push_notification_path(push_notification)
      expect(response).to redirect_to(admin_push_notifications_path)
    end
  end

  describe 'POST /admin/push_notifications/subscribe' do
    let(:subscription_params) { FactoryBot.attributes_for(:push_subscription) }

    it 'creates a new push subscription' do
      expect do
        post subscribe_admin_push_notifications_path, params: subscription_params
      end.to change(PushSubscription, :count).by(1)
      expect(response).to have_http_status(:ok)
    end

    it 'returns an error for invalid subscription params' do
      post subscribe_admin_push_notifications_path, params: subscription_params.merge(endpoint: nil)
      expect(response).to have_http_status(:unprocessable_entity)
    end
  end
end
