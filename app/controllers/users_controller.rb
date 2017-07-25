class UsersController < ApplicationController
	before_action :require_login
	skip_before_action :require_login, only: [:new, :create]


	def index
		@user = User.all	
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
		@user = User.find_by(id: session[:user_id])
	end

	private
	def user_params
		params.require(:user).permit(:username, :password)
	end

  	def require_login
	    unless logged_in?
	      flash[:error] = "You must be logged in to access this section"
	      redirect_to root_path # halts request cycle
    	end
    end
end
