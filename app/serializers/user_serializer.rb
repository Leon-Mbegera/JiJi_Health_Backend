class UserSerializer < ActiveModel::Serializer
  attributes :id, :first_name, :last_name, :email, :last_login_at, :created_at
end
