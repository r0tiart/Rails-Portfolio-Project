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
		@book = Book.new
	end

	def create
		book_params
	end

	private 
	def book_params
		raise params.inspect
		params.require(:book).permit(:title, :author_id => [], :author_attributes => [:name], :genre_id => [], :genre_attributs => [:title])
	end
end