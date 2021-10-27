class CpanelsController < ApplicationController
    skip_before_action :confirm_authentication, only: [:index, :show, :create]
    def index 
        users = User.all
        user_details = users.map{|user|{username: user.username, useremail: user.useremail, account_active: user.account_active }}
        render json: user_details,  status: :ok
    end
end