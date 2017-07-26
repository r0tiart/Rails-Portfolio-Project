module UserBooksHelper
	def user_books
		current_user.books
	end
end