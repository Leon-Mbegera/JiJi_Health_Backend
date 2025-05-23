# app/models/task.rb
class Task < ApplicationRecord
  belongs_to :user
  belongs_to :category

enum :priority, { low: 0, medium: 1, high: 2 }, default: :low
enum :status, { pending: 0, in_progress: 1, completed: 2 }, default: :pending

  validates :title, presence: true
  validates :description, presence: true
  validates :due_date, presence: true
  validates :priority, presence: true
  validates :status, presence: true
  validates :user, presence: true
  validates :category, presence: true
end