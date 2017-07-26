class UserBooksController < ApplicationController 
	def create
		raise params.inspect
		current_user.books
	end
end