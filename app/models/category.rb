# app/models/category.rb
class Category < ApplicationRecord
  has_many :tasks, dependent: :destroy

  validates :name, :description, presence: true, uniqueness: true
  validates :color, format: { with: /\A#([0-9a-fA-F]{3}){1,2}\z/ }
end