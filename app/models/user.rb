class User < ApplicationRecord
	has_many :user_books
	has_many :books, through: :user_books
	has_many :friendships, :foreign_key => "user_id", :class_name => "Friendships"
	has_many :friends, :through => :friendships

	has_secure_password

	before_create :set_friend_id
	def set_friend_id
  		last_friend_id = User.maximum(:friend_id)
 		if !!last_friend_id
  			self.friend_id = last_friend_id + 1
  		else
  			self.friend_id = 1
  		end
	end
end
