module UserBooksHelper
	def user_books
		current_user.books
	end

	def reading?
		!!current_user.books
	end

	def finished_books
		current_user.user_books.where(page: "completed")
	end

	def currently_reading
		books = current_user.user_books.where("page != 'completed'").pluck("book_id")
	end
end