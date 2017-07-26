require 'rails_helper'

describe 'Feature Test: User', :type => :feature do 

	it 'successfully signs up as non-admin' do
	    visit '/'
	    click_link('Sign Up')

	   	expect(current_path).to eq('/users/new')

	    fill_in("user[username]", :with => "Amy Poehler")
	    fill_in("user[password]", :with => "password")
	    click_button('Create User')

	    expect(current_path).to eq('/users/1')
	    expect(page).to have_content("Amy Poehler")
	end

	it "on sign up, successfully adds a session hash" do
		visit '/'
	    click_link('Sign Up')

    	fill_in("user[username]", :with => "Amy Poehler")
	    fill_in("user[password]", :with => "password")
	    click_button('Create User')

	    expect(page.get_rack_session_key('user_id')).to_not be_nil
  	end

	it "on log in, successfully adds a session hash" do
		@user = User.create(
	      username: "user",
	      password: "password",
	    )
	    visit "/"
	    click_link('Log In')

	    fill_in("user[username]", :with => "user")
	    fill_in("user[password]", :with => "password")
	    click_button('Sign In')
	    expect(page.get_rack_session_key('user_id')).to_not be_nil
	end

	it 'prevents user from viewing user show page and redirects to home page if not logged in' do
	    @user = User.create(
	      username: "user",
	      password: "password",
	    )
	    visit '/users/1'
	    expect(current_path).to eq('/')
	    expect(page).to have_content("Sign Up")
	end

	it "on log in, successfully adds a session hash" do
		@user = User.create(
	      username: "user",
	      password: "password",
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
	    expect(page).to have_content(@book.title.titleize)
	end
end


describe 'Feature Test: User Signout', :type => :feature do

  it 'has a link to log out from the users/show page' do
    visit '/'
	click_link('Sign Up')
    fill_in("user[username]", :with => "Amy Poehler")
    fill_in("user[password]", :with => "password")
    click_button('Create User')
    
    expect(page).to have_content("Log Out")
  end

  it 'redirects to home page after logging out' do
    visit '/'
	click_link('Sign Up')
    fill_in("user[username]", :with => "Amy Poehler")
    fill_in("user[password]", :with => "password")
    click_button('Create User')
    click_link("Log Out")
    expect(current_path).to eq('/')
  end

  it "successfully destroys session hash when 'Log Out' is clicked" do
    visit '/'
	click_link('Sign Up')
    fill_in("user[username]", :with => "Amy Poehler")
    fill_in("user[password]", :with => "password")
    click_button('Create User')
    click_link("Log Out")
    expect(page.get_rack_session).to_not include("user_id")
  end
end
