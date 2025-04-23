module JsonWebToken
  extend ActiveSupport::Concern

  # I would use an actual secret key at this step
  SECRET_KEY = "abraeyJhbGciOiJIUzI1NiJ9".freeze

  def generate_jwt_token(user_id)
    payload = { user_id: user_id, exp: 8.hours.from_now.to_i }
    JWT.encode(payload, SECRET_KEY)
  end

  def decode_jwt_token(token)
    begin
      decoded_token = JWT.decode(token, SECRET_KEY, true, algorithm: 'HS256')
      decoded_token[0]

    rescue JWT::DecodeError => e
      nil
    end
  end
end