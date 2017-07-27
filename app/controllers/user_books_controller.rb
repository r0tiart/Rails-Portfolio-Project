class UserBooksController < ApplicationController 
	def create
		current_user.user_books.create(book_id: params[:id])
		redirect_to user_path(current_user)
	end

	def edit 
		@user_book = UserBook.find_by(params[:id])
		@book = Book.find_by(id: @user_book.book_id)
	end

end