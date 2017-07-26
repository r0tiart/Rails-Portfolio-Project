class Book < ApplicationRecord
	belongs_to :genre
	belongs_to :author
	has_many :user_books
	has_many :users, through: :user_books

	validates :title, uniqueness: { case_sensitive: false }
	validates :title, presence: true
end
