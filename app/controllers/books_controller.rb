class BooksController < ApplicationController 
	before_action :require_login
	skip_before_action :require_login, only: [:index]

	def index
		@books = Book.all
		@user_book = UserBook.new
	end

	def show 
		@book = Book.find_by(id: params[:id])
		@user_book = UserBook.find_by(book_id: @book.id, user_id: current_user.id)
	end

	def new
	end

	def create
	end
end