class WatchlistsController < ApplicationController
    skip_before_action :confirm_authentication, only: [:retrieveWL]
    
    def retrieveWL
        watchlist = UserSessionTokenList.all.find_by(session_token: params[:token]).user.watchlist_cards
        render json: watchlist, status: :ok    #locate user based off token recieved
    end
end
