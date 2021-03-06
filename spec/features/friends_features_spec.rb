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


	   	visit "/"
	    click_link('Log In')

	    fill_in("user[username]", :with => "user")
	    fill_in("user[password]", :with => "password")

	    click_button('Sign In')
	end

	it 'has a friend list - of all accepted friends' do
		@user.friend_request=(@user2)

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

	it 'other user profiles have Add friend button if not already a friend' do 
		visit '/users'
		click_link(@user2.username)
		expect(page).to have_link('Add Friend')
	end

	it 'clicking Add Friend link, will give user2 a pending request' do
		visit '/users'
		click_link(@user2.username) 
		expect(page).to have_link('Add Friend')
		click_link('Add Friend')
		expect(@user2.friend_requests.count).to eq(1)
	end


	it 'has links to the friends profile and the pending friends profile, and allows you to accept friend requests' do
		@user.friend_request=(@user2)

		click_link('Log Out')

		visit '/'

		click_link('Log In')

	    fill_in("user[username]", :with => "user2")
	    fill_in("user[password]", :with => "password")

	    click_button('Sign In')

		visit '/users/2/pending_friends'
		expect(page).to have_link(@user.username.titleize)
		click_link(@user.username.titleize)
		expect(page).to have_link('Accept Friend Request')
		click_link('Accept Friend Request')
		visit '/users/2/friends'
		expect(page).to have_link(@user.username.titleize)
	end
end