class ApplicationController < ActionController::API
  require 'jwt'
  include JsonWebToken

  attr_reader :current_user

  private

  def authenticate_request!

    header = request.headers['Authorization']
    token = header.split(' ').last if header

    decoded_token = decode_jwt_token(token)

    if decoded_token && decoded_token['user_id']
      @current_user = User.find_by(id: decoded_token['user_id'])
    end

    unless @current_user
      render json: { error: 'Unauthorized' }, status: :unauthorized
    end
  end
end