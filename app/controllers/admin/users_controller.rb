class Admin::UsersController < ApplicationController
    layout "admin"
    before_action :authenticate_user!
    before_action :set_user, only: %i[edit update destroy]
    def index
        @users = User.all
        @page_title = "Users"
      end

      def show
      end

      def new
        @user = User.new
      end

      def create
        @user = User.new(user_params)

        if @user.save
          respond_to do |format|
            format.html { redirect_to admin_users_path, notice: "User was successfully created." }
            format.turbo_stream { flash.now[:notice] = "User was successfully created." }
          end
        else
          render :new, status: :unprocessable_entity
        end
      end

      def edit
      end

      def update
        if @user.update(user_params)
          respond_to do |format|
            format.html { redirect_to admin_dashboard_users_path, notice: "User was successfully updated." }
            format.turbo_stream { flash.now[:notice] = "User was successfully updated." }
          end
        else
          render :edit, status: :unprocessable_entity
        end
      end

      def destroy
        @user.destroy
        respond_to do |format|
          format.html { redirect_to admin_dashboard_users_path, notice: "User was successfully destroyed." }
          format.turbo_stream { flash.now[:notice] = "User was successfully destroyed." }
        end
      end

      private

      def set_user
        @user = User.find(params[:id])
      end

      def user_params
        params.require(:user).permit(:email, :password, :password_confirmation, :role)
      end
    end
  