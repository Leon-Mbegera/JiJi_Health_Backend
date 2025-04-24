class ApplicationController < ActionController::API
  include JsonWebToken

  attr_reader :current_user

  private

  def authenticate_request!
    header = request.headers['Authorization']
    token = header.split(' ').last if header

    unless token
      render json: { error: 'Not Authenticated: Token missing or invalid format' }, status: :unauthorized and return
    end

    if DenylistedToken.exists?(token: token)
      render json: { error: 'Token is invalid or has been revoked' }, status: :unauthorized and return
    end

    begin
      decoded_token = decode_jwt_token(token)

      if decoded_token && decoded_token['user_id']
        @current_user = User.find_by(id: decoded_token['user_id'])
      end

      unless @current_user
        render json: { error: 'Not Authenticated: User not found or token invalid' }, status: :unauthorized and return
      end

    rescue JWT::DecodeError => e
      render json: { errors: "Not Authenticated: Invalid token - #{e.message}" }, status: :unauthorized and return
    rescue => e
      render json: { errors: "An unexpected authentication error occurred: #{e.message}" }, status: :internal_server_error and return
    end
  end
end
