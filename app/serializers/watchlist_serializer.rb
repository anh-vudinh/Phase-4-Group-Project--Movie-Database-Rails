class WatchlistSerializer < ActiveModel::Serializer
  attributes :id, :wlname
  has_one :user
end
