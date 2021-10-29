class WatchlistsController < ApplicationController
    skip_before_action :confirm_authentication, only: [:create, :destroy, :retrieveWL, :cpWL, :cpWLmovies, :cpWLMoviesDelete]
    
    def create
        newWL = Watchlist.create(user_id: params[:user_id], wlname: params[:wlname])
        render json: newWL, status: :created
    end

    def destroy
        Watchlist.find_by(id: params[:id]).destroy
        render json: {}, status: :accepted
    end

    def retrieveWL
        watchlist = UserSessionTokenList.all.find_by(session_token: params[:token]).user.watchlist_cards
        render json: watchlist, status: :ok    #locate user based off token recieved
    end

    def cpWL 
        user=User.find_by(username: params[:username])
        user_watchlist = user.watchlists
        render json: user_watchlist.to_json(except:[:user]), status: :ok
        
    end 

    def cpWLmovies
        watch_list_card = Watchlist.find_by(id: params[:watchlist_id]).watchlist_cards
        render json: watch_list_card, status: :ok
    end

    def cpWLMoviesDelete
        movie_array = params[:moviesArray]
        movie_array.each{|wl_card| WatchlistCard.find_by(id: wl_card[:id]).destroy}
        updated_wl = Watchlist.find_by(id: params[:selectedWL][:id]).watchlist_cards
        render json: updated_wl, status: :ok
    end

    # private 

    # def watchlists_params
    #     params.permit(:wlname)
    # end
end
