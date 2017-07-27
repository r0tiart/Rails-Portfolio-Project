module FriendsHelper
	def friends
		current_user.friends
	end

	def all_friends_including_pending
		current_user.pending_requests + friends + pending_friend_requests
	end

	def pending_friend_requests
		current_user.friend_requests
	end
end
