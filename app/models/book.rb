class Book < ApplicationRecord
	belongs_to :genre
	belongs_to :author
	has_many :user_books
	has_many :users, through: :user_books

	def reading
		if self.page != "completed"
			true
		end
	end

	def completed
		true if self.page == "completed"
	end

end
