class BooksController < ApplicationController 
	def index
		@books = Book.all
		@user_book = UserBook.new
	end
end