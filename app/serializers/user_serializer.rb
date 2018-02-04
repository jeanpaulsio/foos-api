class UserSerializer < ActiveModel::Serializer
  attributes :id, :handle, :email
end
