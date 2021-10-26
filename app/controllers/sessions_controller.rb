class SessionsController < ApplicationController
    def load
        if params[:token]
            # user = UserSessionTokenList.find_by(session_token: params[:token]).user
            # cookies[:load]
            # session[:load]
            
        else

        end
    end
end
