class Watchlist < ApplicationRecord
  belongs_to :user
  has_many :watchlist_link_cards, dependent: :destroy
  has_many :watchlist_cards, through: :watchlist_link_cards
end
