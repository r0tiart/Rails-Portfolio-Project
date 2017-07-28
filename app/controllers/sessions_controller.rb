class SessionsController < ApplicationController

	def new
	end

	def create
		if auth 
   			@user = User.find_or_create_by(uid: auth['uid']) do |u|
		 		u.username = auth['info']['name']
		 		u.password = SecureRandom.hex
			end
 
	    	session[:user_id] = @user.id
 
	    	redirect_to user_path(@user)

		else
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

	def destroy
		session.destroy
		redirect_to "/"
	end

	private
	def auth
    	request.env['omniauth.auth']
  	end

end