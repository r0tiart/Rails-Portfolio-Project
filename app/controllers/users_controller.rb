class UsersController < ApplicationController

	def index
	end

	def new
		@user = User.new
	end

	def create
		@user = User.new(user_params)

		if @user.save
			redirect_to user_path(@user)
		else
			# @user.errors.messages.each do |message|
			# 	flash[:alert] << message.flatten.join(": ")
			# end
			render "/users/new"
		end
	end

	def show

	end

	private
	def user_params
		params.require(:user).permit(:username, :password)
	end
end
