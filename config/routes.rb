Rails.application.routes.draw do
  
  resources :cpanels
  #resources :sessions
  #resources :user_session_token_lists
  #resources :watchlist_link_cards
  #resources :watchlist_cards
  #resources :review_movies
  #resources :review_responses
  #resources :user_responses
  #resources :user_reviews
  #resources :movies
  resources :responses
  resources :reviews
  resources :users

  resources :watchlist_cards do
    collection do
      patch 'deleteWLC'
    end
  end

  resources :watchlists do
    collection do
      post 'retrieveWL'
    end
    collection do
      post 'cpWL'
    end
    collection do
      post 'cpWLmovies'
    end
  end
  
  resources :sessions do
    collection do
      post 'login'
    end
    collection do
      post 'token_login'
    end
  end
  

  # Routing logic: fallback requests for React Router.
  # Leave this here to help deploy your app later!
  get "*path", to: "fallback#index", constraints: ->(req) { !req.xhr? && req.format.html? }
end
