class FriendsController < ApplicationController
	def index
		@friends = current_user.friends
	end

	def pending_friends
		@friends = current_user.friend_requests
	end
end
