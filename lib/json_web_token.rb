module JsonWebToken
  extend ActiveSupport::Concern

  # I would use an actual secret key at this step
  SECRET_KEY = "abraeyJhbGciOiJIUzI1NiJ9".freeze

  def generate_jwt_token(user_id)
    payload = { user_id: user_id, exp: 8.hours.from_now.to_i }
    JWT.encode(payload, SECRET_KEY)
  end
end