module FriendsHelper
	def friends
		current_user.friends
	end

	def pending
		current_user.friend_requests
	end
end
