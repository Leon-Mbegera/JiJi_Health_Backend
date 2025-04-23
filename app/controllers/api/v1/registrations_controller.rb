module Api
  module V1
    class RegistrationsController  < ApplicationController
      def create
        @user = ::User.create(registration_params)

        if @user.persisted?
          @user.update(last_login_at: Time.current)
          token = generate_jwt_token(@user.id)

          render json: {
            user: UserSerializer.new(@user),
            token: token
          }
        else
          render json: @user.errors, status: :unprocessable_entity
        end
      end

      private

      def registration_params
        params.require(:user).permit(:first_name, :last_name, :email, :password, :password_confirmation)
      end
    end
  end
end
