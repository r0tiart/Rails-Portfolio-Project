class User < ApplicationRecord
	has_many :user_books
	has_many :books, through: :user_books
	has_many :friendships, :foreign_key => "user_id", :class_name => "Friendships"
	has_many :friends, :through => :friendships


end
