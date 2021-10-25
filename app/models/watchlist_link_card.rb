class WatchlistLinkCard < ApplicationRecord
  belongs_to :watchlist
  belongs_to :watchlist_card
end
