class User < ApplicationRecord
	has_many :user_books
	has_many :books, through: :user_books
	has_many :friendships, :foreign_key => "user_id", :class_name => "Friendship"
	has_many :friends, :through => :friendships

	has_secure_password

	before_create :set_friend_id

	def friend_request=(user)
		if User.all.include?(user)
			self.friend_ids=(user.friend_id) 
			friendship = self.friendships.where(friend_id: user.friend_id).first
			friendship.status = "pending"
			friendship.save
			self.save
		end
	end

	def friend_requests
		Friendship.where(friend_id: self.friend_id, status: "pending")	
	end

	private
	def set_friend_id
  		last_friend_id = User.maximum(:friend_id)
 		if !!last_friend_id
  			self.friend_id = last_friend_id + 1
  		else
  			self.friend_id = 1
  		end
	end
end
