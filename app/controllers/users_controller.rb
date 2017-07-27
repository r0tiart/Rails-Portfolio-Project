class UsersController < ApplicationController
	before_action :require_login
	skip_before_action :require_login, only: [:new, :create]


	def index
		@users = User.all	
	end

	def new
		if logged_in?
			redirect_to user_path(current_user)
		else
			@user = User.new
		end
	end

	def create
		@user = User.new(user_params)

		if @user.save
			session[:user_id] = @user.id
			redirect_to user_path(@user)
		else
			flash[:alert]
			render :new
		end
	end

	def show
		@user = User.find_by(id: params[:id])
	end

	private
	def user_params
		params.require(:user).permit(:username, :password)
	end
end
