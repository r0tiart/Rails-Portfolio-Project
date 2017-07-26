module FriendsHelper
	def friends
		current_user.friends
	end

	def pending_friends
		current_user.friend_requests + current_user.pending_requests + friends
	end
end
