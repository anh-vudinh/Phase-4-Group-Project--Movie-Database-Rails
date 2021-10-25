class WatchlistLinkCardSerializer < ActiveModel::Serializer
  attributes :id
  has_one :watchlist
  has_one :watchlist_card
end
