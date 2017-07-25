class SessionsController < ApplicationController

	def new
	end

	def create
		@user = User.find_by(username: params[:user][:username])
		if @user && @user.authenticate(params[:user][:password])
			session[:user_id] = @user.id
			redirect_to user_path(@user)
		else
			flash[:alert] = "Username and/or password is incorrect"

			render :new
		end
	end

end