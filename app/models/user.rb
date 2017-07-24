class User < ApplicationRecord
	has_many :user_books
	has_many :books, through: :user_books
	has_many :friendships, -> { Friendship.accepted }, :foreign_key => "user_id", :class_name => "Friendship"
	has_many :friends, :through => :friendships


	has_secure_password

	before_create :set_friend_id

	def friend_request=(user)
		if User.all.include?(user)
			Friendship.friend_request(self, user)
		end
	end

	def friend_requests
		Friendship.requests(self)
	end

	def accept_friend_request(user)

		if User.all.include?(user)
			Friendship.accept_request(user, self)
		end
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
