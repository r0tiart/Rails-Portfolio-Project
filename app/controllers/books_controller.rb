class BooksController < ApplicationController 
	before_action :require_login
	skip_before_action :require_login, only: [:index]

	def index
		if params[:user_id]
			user = User.find(params[:user_id])
			@books = user.books
		else
			@books = Book.all
		end
		
		respond_to do |format|
	      format.html { render :index }
	      format.json { render json: @books}
    	end
		# @user_book = UserBook.new
	end

	def show 
		
		@book = Book.find_by(id: params[:id])
		@user_book = UserBook.find_by(book_id: @book.id, user_id: current_user.id)
		@last_book = Book.last
		
		respond_to do |format|
	      format.html { render :show }
	      format.json { render json: @book}
    	end
	end

	def new
		@book = Book.new
	end

  def create
    @book = Book.new(book_params)
	if @book.save
		current_user.user_books.create(book_id: @book.id)
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
			params.require(:book).permit(:title, :author_id, :genre_attributes => [:title])
		elsif !author_id? && genre_id?
			params.require(:book).permit(:title, :genre_id, :author_attributes => [:name])
		else
			params.require(:book).permit(:title, :genre_attributes => [:title], :author_attributes => [:name])
		end
	end

	def author_id?
		params[:book][:author_id] != ""
	end	

	def genre_id?
		params[:book][:genre_id] != ""
	end
end