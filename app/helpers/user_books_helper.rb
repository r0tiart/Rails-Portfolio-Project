module UserBooksHelper
	def user_books
		current_user.books
	end

	def reading?
		!!current_user.books
	end

	def finished_books
		ids = current_user.user_books.where(page: "completed").pluck("book_id").flatten
		books = ids.collect{|id| Book.where(id: id)}.flatten
	end

	def currently_reading
		ids = current_user.user_books.where("page != 'completed'").pluck("book_id").flatten
		books = ids.collect{|id| Book.where(id: id)}.flatten
	end

	def current_book(book) 
		current_user.user_books.where(book_id: book.id).first
	end

	def favorite?(book)
		current_user.user_books.where(book_id: book.id).first.favorite?
	end
end