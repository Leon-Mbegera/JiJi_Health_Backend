class Api::V1::TaskSerializer < ActiveModel::Serializer
  attributes :id, :title, :description, :due_date, :priority, :status
  has_one :user
  has_one :category
end
