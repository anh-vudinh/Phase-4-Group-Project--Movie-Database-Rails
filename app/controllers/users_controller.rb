class UsersController < ApplicationController
    skip_before_action :confirm_authentication, only: [:create]

    def create
        if User.find_by(username: params[:username])
            render json: {errors: "user_exist", status: 422}, status: :unprocessable_entity
        else
            newUser = User.create(username: params[:username], useremail: nil, avatar_path: nil, userpwd: params[:password], password: params[:password], login_status: true, account_active: true, is_admin: false)
            newToken = createNewSessionToken
            UserSessionTokenList.create( user_id: newUser.id, session_token: newToken, session_duration: 1, exp_end:DateTime.now+1)
            render json: {token: newToken, username: newUser.username}, status: :ok
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
