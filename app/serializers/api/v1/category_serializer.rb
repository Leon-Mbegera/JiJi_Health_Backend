class Api::V1::CategorySerializer < ActiveModel::Serializer
  attributes :id, :name, :description, :color
end
