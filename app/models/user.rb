class User < ApplicationRecord
    has_many :watchlists, dependent: :destroy
    has_many :watchlist_link_cards, through: :watchlists
    has_many :watchlist_cards, through: :watchlist_link_cards
    has_many :user_session_token_lists, dependent: :destroy
    
    has_many :user_reviews, dependent: :destroy
    has_many :reviews, through: :user_reviews
    has_many :review_movies, through: :reviews
    has_many :movies, through: :reviews_movies
    has_many :user_responses, dependent: :destroy
    has_many :responses, through: :user_responses 

    validates :username, uniqueness: true
    validates :useremail, uniqueness: { allow_nil: true }

    has_secure_password
end
