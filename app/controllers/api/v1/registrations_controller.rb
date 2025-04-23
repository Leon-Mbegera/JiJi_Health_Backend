module Api
  module V1
    class RegistrationsController  < ApplicationController
      def create
        @user = ::User.create(registration_params)

        if @user.save
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
        params.require(:user).permit(:name, :email, :password, :password_confirmation)
      end
    end
  end
end
