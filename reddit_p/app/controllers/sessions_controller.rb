class SessionsController < ApplicationController
    before_action :ensure_logged_in, only: [:destroy]

    def create
        @user = User.find_by_credentials(
            params[:user][:username],
            params[:user][:password]
        )
        if @user 
            login!(@user)
            redirect_to users_url(@user)
        else
            flash.now[:username] = params[:user][:username]
            flash.now[:errors] = ["Invalid Credentials"]
            render :new
        end
    end

    def new 
        render :new
    end 

    def destroy 
        logout
        redirect_to new_session_url
    end
end