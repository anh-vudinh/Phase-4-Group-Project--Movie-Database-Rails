class SessionsController < ApplicationController
    skip_before_action :confirm_authentication, only: [:login, :token_login]

    def login
        search_user = User.find_by(username: params[:username])
        if search_user
            if search_user.account_active
                if search_user&.authenticate(params[:password])                    #allow newUser login
                    possibleToken = search_user.user_session_token_lists.find {|ustl| ustl.exp_end >= DateTime.now}
                    set_session_duration = search_user.user_session_token_lists.last.session_duration ||= 1
                    if possibleToken != nil                                    #user has no expired usable session token
                        token = possibleToken.session_token
                        render json: {token: token, username: search_user.username, useremail: search_user.useremail, avatar_path: search_user.avatar_path, account_active: search_user.account_active, session_duration: set_session_duration}, status: :ok                    #so return token to front end
                    else
                        newToken = createNewSessionToken                       #user does not have usable token, create new token
                        UserSessionTokenList.create(user_id: search_user.id, session_token: newToken, session_duration: set_session_duration, exp_end: DateTime.now+set_session_duration)
                        render json: {token: newToken, username: search_user.username, useremail: search_user.useremail, avatar_path: search_user.avatar_path, account_active: search_user.account_active, session_duration: set_session_duration}, status: :ok                                       #return to front end
                    end 
                else
                    render json: {errors: "Wrong Password", status: 422}, status: :unprocessable_entity                                         #wrong password
                end
            else
                render json: {errors: "Account Disabled", status: 422}, status: :unprocessable_entity
            end
        else                                                                #no user exist
            render json: {errors: "User doesn't exist", status: 404}, status: :not_found
        end
    end

    def token_login
        if params[:token] === "undefined"
            render json: {errors: "Auto login failed, bad session", status: 404}, status: :not_found
        else
            account_active = UserSessionTokenList.find_by(session_token: params[:token]).user.account_active
            if account_active
                searchToken = UserSessionTokenList.find_by(session_token: params[:token])
                if searchToken
                    search_user = searchToken.user
                    set_session_duration = search_user.user_session_token_lists.last.session_duration ||= 1
                    if searchToken.exp_end >= DateTime.now
                        #good token, log user in
                        render json: {token: searchToken.session_token, username: search_user.username, useremail: search_user.useremail, avatar_path: search_user.avatar_path, account_active: search_user.account_active, session_duration: set_session_duration}, status: :ok
                    else
                        #create new token because first one expired
                        render json: {errors: "Login again, session expired", status: 422}, status: :unprocessable_entity
                    end
                else
                    render json: {errors: "Auto Login Failed, User doesn't exist", status: 404}, status: :not_found
                end
            else
                render json: {errors: "Account Disabled", status: 422}, status: :unprocessable_entity
            end
        end
    end

    def createNewSessionToken
        possibleToken = Faker::Alphanumeric.alphanumeric(number: 30, min_alpha: 3)
        if UserSessionTokenList.find_by(session_token: possibleToken) == nil
            possibleToken
        else
            createNewSessionToken
        end
    end
end
