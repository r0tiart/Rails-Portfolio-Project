class UserBooksController < ApplicationController 
	def create
		current_user.user_books.create(book_id: params[:id])
		redirect_to user_path(current_user)
	end

	def edit 
		@book = UserBook.find_by(params[:id])
	end

end