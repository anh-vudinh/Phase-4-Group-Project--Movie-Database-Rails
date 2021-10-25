class ReviewSerializer < ActiveModel::Serializer
  attributes :id, :author, :content, :username, :avatar_path, :rating
end
