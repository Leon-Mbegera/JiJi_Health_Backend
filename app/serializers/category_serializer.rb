class CategorySerializer < ActiveModel::Serializer
  attributes :id, :name, :description, :color, :created_at
end
