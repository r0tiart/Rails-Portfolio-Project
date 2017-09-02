class UserBooksController < ApplicationController 

	# def index
	# 	user = User.find(params[:user_id])
	# 	@books = user.books
	# end
	def create
		current_user.user_books.create(book_id: params[:id])
		redirect_to user_path(current_user)
	end

	def edit 
		@book = Book.find_by(id: params[:id])
		@user_book = current_user.user_books.find_by(book_id: @book.id)
	end

	def update

		@user_book = UserBook.find_by(id: params[:id])
		@book = Book.find_by(id: @user_book.book_id)
		if !!@user_book.update(user_book_params)
			redirect_to book_path(@user_book.book_id)
		else
			render :edit
		end
	end

	private

	def user_book_params
		params.require(:user_book).permit(:page)
	end

end