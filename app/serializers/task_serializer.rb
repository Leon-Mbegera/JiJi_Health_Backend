class CategorySerializer < ActiveModel::Serializer
  attributes :id, :title, :due_date, :priority, :status, :category, :created_at
end
