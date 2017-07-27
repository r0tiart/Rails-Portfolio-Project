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
    @book = Book.new(book_params)
	if @book.save
		redirect_to book_path(@book)
	else
		render :new
	end
  end

	private 
	def book_params
		if author_id? && genre_id?
			params.require(:book).permit(:title, :author_id, :genre_id)
		elsif author_id? && !genre_id?
			params.require(:book).permit(:title, :author_id, :genre_attribues => [:title])
		elsif !author_id? && genre_id?
			params.require(:book).permit(:title, :genre_id, :author_attributes => [:name])
		else
			params.require(:book).permit(:title, :genre_attribues => [:title], :author_attributes => [:name])
		end
	end

	def author_id?
		!!params[:book][:author_id]
	end	

	def genre_id?
		!!params[:book][:genre_id]
	end
end