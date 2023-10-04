module Admin
  class PushNotificationsController < ApplicationController
    layout "admin"
    before_action :authenticate_user!, except: [:subscribe]
    before_action :authorize_admin!, except: [:subscribe]
    before_action :set_push_notification, only: %i[show edit update destroy]

    def index
      @push_notifications = PushNotification.all
      @page_title = "Push Notifications"
    end

    def show
      @page_title = "Push Notification Details"
    end

    def new
      @push_notification = PushNotification.new
    end

    def create
      @push_notification = PushNotification.new(push_notification_params)

      if @push_notification.save
        send_push_notification(@push_notification)
        respond_to do |format|
          format.html do
            redirect_to admin_push_notifications_path, notice: "Push Notification was successfully created"
          end
          format.turbo_stream { flash.now[:notice] = "Push Notification was successfully created" }
        end
      else
        render :new, status: :unprocessable_entity
      end
    end

    def destroy
      @push_notification.destroy
      respond_to do |format|
        format.html do
          redirect_to admin_push_notifications_path, notice: "Push Notification was successfully destroyed."
        end
        format.turbo_stream do
          flash.now[:notice] = "Push Notification was successfully destroyed."
        end
      end
    end

    def subscribe
      subscription = PushSubscription.new(
        endpoint: params[:endpoint],
        p256dh: params[:p256dh],
        auth: params[:auth],
        subscribed: true
      )

      if subscription.save
        render json: { message: "Subscription successfully saved" }, status: :ok
      else
        render json: { error: "Error in storing subscription" }, status: :unprocessable_entity
      end
    end

    private

    def set_push_notification
      @push_notification = PushNotification.find(params[:id])
    end

    def push_notification_params
      params.require(:push_notification).permit(:title, :body)
    end

    def send_push_notification(push_notification)
      subscriptions = active_push_subscriptions
      latest_subscription = subscriptions.last
      return unless latest_subscription

      message = build_push_message(push_notification)
      vapid_details = build_vapid_details
      send_web_push_notification(message, latest_subscription, vapid_details)
    end

    def active_push_subscriptions
      PushSubscription.where(subscribed: true)
    end

    def build_push_message(push_notification)
      {
        title: push_notification.title,
        body: push_notification.body,
        icon: push_notification_icon_url
      }
    end

    def push_notification_icon_url
      ActionController::Base.helpers.image_url("note.png")
    end

    def build_vapid_details
      {
        subject: "mailto:#{ENV['DEFAULT_EMAIL']}",
        public_key: ENV["DEFAULT_APPLICATION_SERVER_KEY"],
        private_key: ENV["DEFAULT_PRIVATE_KEY"]
      }
    end

    def send_web_push_notification(message, subscription, vapid_details)
      WebPush.payload_send(
        message: JSON.generate(message),
        endpoint: subscription.endpoint,
        p256dh: subscription.p256dh,
        auth: subscription.auth,
        vapid: vapid_details
      )
    end

    def authorize_admin!
      return if current_user.admin?

      redirect_to root_path, alert: "You are not authorized to access this page."
    end
  end
end
