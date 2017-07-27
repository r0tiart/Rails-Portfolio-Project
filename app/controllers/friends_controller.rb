class FriendsController < ApplicationController
	def index
		@friends = current_user.friends
	end

	def pending_friends
		@friends_requests = current_user.friend_requests
		@pending_friends = current_user.pending_requests
	end

	def create
		user = User.find_by(id: params[:user_id])
		current_user.friend_request=user
		redirect_to user_path(current_user)
	end

	def update
		@user = User.find_by(id: params[:id])
		@user.accept_friend_request(current_user)
		redirect_to user_path(current_user)
	end
end
