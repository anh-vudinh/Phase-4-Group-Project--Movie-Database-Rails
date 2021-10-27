class SessionsController < ApplicationController
    skip_before_action :confirm_authentication, only: [:login, :token_login]

    def login
        searchUser = User.find_by(username: params[:username])
        if searchUser != nil
            if searchUser&.authenticate(params[:password])                    #allow newUser login
                possibleToken = searchUser.user_session_token_lists.find {|ustl| ustl.exp_end >= DateTime.now}
                if possibleToken != nil                                    #user has no expired usable session token
                    token = possibleToken.session_token
                    render json: {token: token, username: searchUser.username}, status: :ok                    #so return token to front end
                else
                    newToken = createNewSessionToken                       #user does not have usable token, create new token
                    UserSessionTokenList.create( user_id: searchUser.id, session_token: newToken, session_duration: 1, exp_start: DateTime.now, exp_end:DateTime.now+1)
                    render json: {token: newToken, username: searchUser.username}, status: :ok                                       #return to front end
                end 
            else
                render json: {errors: "wrong_pwd", status: 422}, status: :unprocessable_entity                                         #wrong password
            end
        else                                                                #no user exist
            render json: {errors: "no_user", status: 404}, status: :not_found
        end
    end

    def token_login
        searchToken = UserSessionTokenList.find_by(session_token: params[:token])
        if searchToken
            if searchToken.exp_end >= DateTime.now 
                #good token, log user in
                render json: {token: searchToken.session_token, username: searchToken.user.username}, status: :ok
            else
                #create new token because first one expired
                render json: {errors: "token expired requires user to login", status: 422}, status: :unprocessable_entity
            end
        else
            render json: {errors: "no_user", status: 404}, status: :not_found
        end
    end
  
    # def destroy
    #     session.delete :user_id
    #     head :no_content
    # end

    def createNewSessionToken
        possibleToken = Faker::Alphanumeric.alphanumeric(number: 20, min_alpha: 3)
        if UserSessionTokenList.find_by(session_token: possibleToken) == nil
            possibleToken
        else
            createNewSessionToken
        end
    end
end
