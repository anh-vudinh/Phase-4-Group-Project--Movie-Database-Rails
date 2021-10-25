class UserResponseSerializer < ActiveModel::Serializer
  attributes :id
  has_one :user
  has_one :response
end
