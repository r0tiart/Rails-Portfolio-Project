require 'rails_helper'

describe 'Feature Test: Friend', :type => :feature do 

	before do
		User.destroy_all
		Author.destroy_all
		Book.destroy_all
		Genre.destroy_all

		@user = User.create(
	      username: "user",
	      password: "password",
	    )

	    @user2 = User.create(
	      username: "user2",
	      password: "password"
	    )

	    @book = Book.create(title: "book1")
	    @author = Author.create(name: "author1")
	    @genre = Genre.create(title: "genre1")
	    @book.author = @author
	    @book.genre = @genre
		@book.save

		@user.user_books.create(book_id: @book.id)
		@user.friend_request=(@user2)


	   	visit "/"
	    click_link('Log In')

	    fill_in("user[username]", :with => "user")
	    fill_in("user[password]", :with => "password")

	    click_button('Sign In')
	end

	it 'has a friend list - of all accepted friends' do
		@user2.accept_friend_request(@user)
		visit '/users/1/friends'
		expect(page).to have_content(@user.username.titleize)
		visit '/users/2/friends'
		expect(page).to have_content(@user2.username.titleize)
	end

	it 'has a pending friend list' do 
		visit '/users/2/pending_friends'
		expect(page).to have_content(@user.username.titleize)
	end
end