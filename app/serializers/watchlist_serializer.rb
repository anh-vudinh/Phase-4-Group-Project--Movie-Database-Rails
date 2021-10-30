class WatchlistSerializer < ActiveModel::Serializer
  attributes :id, :wlname, :is_default
  # has_one :user
end
