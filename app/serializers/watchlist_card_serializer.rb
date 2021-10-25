class WatchlistCardSerializer < ActiveModel::Serializer
  attributes :id, :movie_id, :movie_name, :movie_year, :movie_rating, :movie_backdrop
end
