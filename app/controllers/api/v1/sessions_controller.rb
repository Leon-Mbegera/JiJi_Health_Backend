module Api
  module V1
    class SessionsController < ApplicationController
      before_action :authenticate_request!, only: [:destroy]

      def create
        @user = ::User.find_by(email: session_params[:email])

        if @user && @user.authenticate(session_params[:password])
          @user.update(last_login_at: Time.current)
          token = generate_jwt_token(@user.id)
          render json: { user: UserSerializer.new(@user), token: token }, status: :ok
        else
          render json: { error: 'Invalid email or password' }, status: :unauthorized
        end
      end

      def destroy
        header = request.headers['Authorization']
        token = header.split(' ').last if header

        unless token
          render json: { error: 'Logout failed: Token missing or invalid format' }, status: :unprocessable_entity and return
        end

        DenylistedToken.create!(token: token)
        render json: { message: 'Logged out successfully' }, status: :ok

      rescue ActiveRecord::RecordInvalid => e
        Rails.logger.error "Denylist creation failed: #{e.message}"
        render json: { error: "Logout failed: #{e.message}" }, status: :unprocessable_entity
      rescue => e
        Rails.logger.error "An unexpected error occurred during logout: #{e.message}"
        render json: { error: "An unexpected error occurred during logout: #{e.message}" }, status: :internal_server_error
      end

      private

      def session_params
        params.require(:user).permit(:email, :password)
      end
    end
  end
end
