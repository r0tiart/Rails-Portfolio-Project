class FriendsController < ApplicationController
	def index
		@friends = current_user.friends
	end

	def pending_friends
		@friends = current_user.friend_requests
	end

	def create
		user = User.find_by(id: params[:user_id])
		current_user.friend_request=user
		redirect_to user_path(user)
	end
end
