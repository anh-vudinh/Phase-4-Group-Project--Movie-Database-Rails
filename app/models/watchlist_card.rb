class WatchlistCard < ApplicationRecord
    has_many :watchlist_link_cards, dependent: :destroy
    has_many :watchlist, through: :watchlist_link_cards
end
