module Api
  module V1
    class ProfilesController < ApplicationController
      before_action :authenticate_request!

      def show
        render json: @current_user, status: :ok
      end

      def update
        if @current_user.update(profile_params)
          render json: @current_user, status: :ok
        else
          render json: @current_user.errors, status: :unprocessable_entity
        end
      end

      private

      def profile_params
        params.require(:user).permit(:first_name, :last_name, :email)
      end
    end
  end
end
