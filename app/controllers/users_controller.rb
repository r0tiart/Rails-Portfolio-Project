class UsersController < ApplicationController

	def index
	end

	def new
		@user = User.new
	end

	def create
		@user = User.new(user_params)

		if @user.save
			session[:user_id] = @user.id
			redirect_to user_path(@user)
		else
			flash[:alert] = "There are some errors creating the user"
			render "/users/new"
		end
	end

	def show
		@user = User.find_by(id: session[:user_id])
		raise current_user.inspect
	end

	private
	def user_params
		params.require(:user).permit(:username, :password)
	end
end
