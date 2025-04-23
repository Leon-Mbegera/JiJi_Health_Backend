class User < ApplicationRecord
  has_secure_password

  validates :first_name, :last_name, presence: true
  validates :email, presence: true,
                    uniqueness: true,
                    format: {
                      with: /\A[^@\s]+@[^@\s]+\.[^@\s]+\z/,
                      message: 'must be a valid email address'
                    }
  validates :password, :password_confirmation, presence: true
end
