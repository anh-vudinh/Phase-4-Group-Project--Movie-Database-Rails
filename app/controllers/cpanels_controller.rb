class CpanelsController < ApplicationController
    skip_before_action :confirm_authentication, only: [:index, :show, :create]
    def index 
        users = User.all
        user_details = users.map{|user|{id:user.id, username: user.username, useremail: user.useremail, account_active: user.account_active, avatar_path: user.avatar_path}}
        render json: user_details,  status: :ok
    end
end
