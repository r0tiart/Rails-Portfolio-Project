class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  	def welcome
  		if logged_in?
  			redirect_to user_path(current_user)
  		end
  	end

	private
	def logged_in?
		!!current_user
	end

	def current_user
		@current_user ||= User.find(session[:user_id]) if session[:user_id]
	end
end
