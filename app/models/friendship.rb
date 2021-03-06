class Friendship < ApplicationRecord
	
	belongs_to :user
	# , :foreign_key => "user_id", :class_name => "User"
	belongs_to :friend, :foreign_key => "friend_id", :class_name => "User"  
	scope :accepted, -> { where(status: "accepted") }
	scope :pending, -> { where(status: "pending")}

	private

	def self.friend_request(requester, requestee)
		    self.find_or_create_by(user_id: requester.id, friend_id: requestee.friend_id)
	end

	def self.requests(user)
	   user_requests = self.where(friend_id: user.friend_id, status: "pending")	
	   user_requests.collect{ |request| request.user}
	end

	def self.pending_requests(user)
		friends_pending = self.where(user_id: user.id, status: "pending")
		friends_pending.collect{ |request| request.friend}
	end

	def self.accept_request(requester, requestee)
		request = self.where(user_id: requester.id, friend_id: requestee.friend_id, status: "pending")	
		accept = self.friend_request(requestee, requester)
		self.approve(request, accept)
	end

	def self.approve(request, accept)
		request.update(status: "accepted")
		accept.update(status: "accepted")
	end

end
