class UserReviewSerializer < ActiveModel::Serializer
  attributes :id
  has_one :user
  has_one :review
end
