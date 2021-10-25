Rails.application.routes.draw do
  
  resources :user_session_token_lists
  resources :watchlist_link_cards
  resources :watchlist_cards
  resources :watchlists
  resources :review_movies
  resources :review_responses
  resources :user_responses
  resources :user_reviews
  resources :movies
  resources :responses
  resources :reviews
  resources :users
  # Routing logic: fallback requests for React Router.
  # Leave this here to help deploy your app later!
  get "*path", to: "fallback#index", constraints: ->(req) { !req.xhr? && req.format.html? }
end
