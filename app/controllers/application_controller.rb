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

	 def require_login
	    unless logged_in?
	      flash[:error] = "You must be logged in to access this section"
	      redirect_to root_path # halts request cycle
    	end
    end
end


