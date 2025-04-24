class DenylistedToken < ApplicationRecord
  validates :token, presence: true, uniqueness: true
end
