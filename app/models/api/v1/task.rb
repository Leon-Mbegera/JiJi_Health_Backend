class Api::V1::Task < ApplicationRecord
  belongs_to :user
  belongs_to :category
end
