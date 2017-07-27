class BooksController < ApplicationController 
	before_action :require_login
	skip_before_action :require_login, only: [:index]

	def index
		@books = Book.all
		@user_book = UserBook.new
	end

end