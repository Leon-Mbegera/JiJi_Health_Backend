module Api
  module V1
    module User
      class SessionsController < ApplicationController
        def create
          @user = ::User.find_by(email: session_params[:email])

          if @user && @user.authenticate(session_params[:password])
            token = generate_jwt_token(@user.id)

            render json: { user: UserSerializer.new(@user), token: token }, status: :ok
          else
            render json: { error: 'Invalid email or password' }, status: :unauthorized
          end
        end

        private

        def session_params
          params.require(:user).permit(:email, :password)
        end
      end
    end
  end
end
