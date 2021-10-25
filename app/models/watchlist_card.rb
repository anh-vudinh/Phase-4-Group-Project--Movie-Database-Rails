class WatchlistCard < ApplicationRecord
    has_many :watchlist_link_cards
    has_many :watchlist, through: :watchlist_link_cards
end
