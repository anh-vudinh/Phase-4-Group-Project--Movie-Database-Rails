class WatchlistsController < ApplicationController
    def index
        watchlist = UserSessionTokenList.all.find_by(session_token: params[:token]).user.watchlist_cards
        render json: watchlist    #locate user based off token recieved
    end
end
