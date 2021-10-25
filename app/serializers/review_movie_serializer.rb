class ReviewMovieSerializer < ActiveModel::Serializer
  attributes :id
  has_one :review
  has_one :movie
end
