class UsersController < ApplicationController
   
    def create 
        if User.find_by(username: params[:username])
            render json: {errors: "user_exist"}, status: :unprocessable_entity
        else
            newUser = User.create(username: params[:username], useremail: nil, userpwd: params[:password], login_status: true, account_active: true)
            newToken = createNewSessionToken
            UserSessionTokenList.create( user_id: newUser.id, session_token: newToken, session_duration: 1, exp_end:DateTime.now+1)
            render json: newToken, status: :ok
        end
    end
  
    post '/users/login' do
        byebug
        searchUser = User.find_by(username: params[:username])
        if searchUser != nil 
            if searchUser.userpwd == params[:password]                     #allow newUser login
                possibleToken = searchUser.user_session_token_lists.find {|ustl| ustl.exp_end >= DateTime.now}
                if possibleToken != nil                                    #user has no expired usable session token
                    possibleToken.session_token.to_json                    #so return token to front end
                else
                    newToken = createNewSessionToken                       #user does not have usable token, create new token
                    UserSessionTokenList.create( user_id: searchUser.id, session_token: newToken, session_duration: 1, exp_start: DateTime.now, exp_end:DateTime.now+1)
                    newToken.to_json                                       #return to front end
                end 
            else
                "wrong_pwd".to_json                                         #wrong password
            end
        else                                                                #no user exist
            "no_user".to_json
        end
    end

    def createNewSessionToken
        possibleToken = Faker::Alphanumeric.alphanumeric(number: 20, min_alpha: 3)
        if UserSessionTokenList.find_by(session_token: possibleToken) == nil
            possibleToken
        else
            createNewSessionToken
        end
    end

end
