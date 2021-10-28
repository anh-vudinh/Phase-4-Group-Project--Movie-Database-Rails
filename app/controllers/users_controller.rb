class UsersController < ApplicationController
    skip_before_action :confirm_authentication, only: [:create, :destroy, :update] 

    def create
        if User.find_by(username: params[:username])
            render json: {errors: "user_exist", status: 422}, status: :unprocessable_entity
        else
            newUser = User.create(username: params[:username], useremail: params[:useremail] ||= nil, avatar_path: nil, password: params[:password], login_status: true, account_active: true, is_admin: false)
            newToken = createNewSessionToken
            UserSessionTokenList.create( user_id: newUser.id, session_token: newToken, session_duration: 1, exp_end:DateTime.now+1)
            render json: {token: newToken, username: newUser.username}, status: :ok
        end
    end

    def update
        user = User.find_by(id: params[:id])
        user_session_list = user.user_session_token_lists.last
        
        if params[:session_duration].to_i < 0 || params[:session_duration].to_i > 30 
            new_session_duration = 1
        else
            new_session_duration = params[:session_duration].to_i
        end

        user_session_list.update(session_duration: new_session_duration)
        updated_user = user.update(useremail: params[:useremail], password: params[:password], account_active: params[:account_active], avatar_path: params[:avatar_path])
        
        if updated_user
            render json: {useremail: params[:useremail], password: params[:password], avatar_path: params[:avatar_path], account_active: params[:accout_active]}, status: :ok
        else
            render json: {errors: "unable to update"}, status: :unprocessable_entity
        end
    end
    
    def destroy
        User.find_by(id:params[:id]).destroy
        render json: {}, status: :accepted
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
