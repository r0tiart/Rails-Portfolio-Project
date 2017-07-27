require 'rails_helper'

describe 'Feature Test: Book', :type => :feature do 
	before do 
		Author.destroy_all
		Book.destroy_all
		Genre.destroy_all
		User.destroy_all

		@book = Book.create(title: "book1")
		@author = Author.create(name: "author1")
		@genre = Genre.create(title: "genre1")
		@book.author = @author
		@book.genre = @genre
		@book.save

		@user = User.create(username: "user", password: "password")

	end

	it 'allows non logged in user to see list of books people are reading' do
	
		visit '/books'
	    expect(page).to have_content(@book.title.titleize)
	    expect(page).to have_content(@author.name.titleize)
	    expect(page).to have_no_link(@book.title.titleize)
	end


	it 'has a link to show page if logged in' do 
		visit "/"
	    click_link('Log In')

	    fill_in("user[username]", :with => "user")
	    fill_in("user[password]", :with => "password")
		click_button('Sign In')	

		visit '/books'	
		expect(page).to have_link(@book.title.titleize)
	end

	it 'allows you to add book in the book show page & redirects to /books if not logged in' do 
		visit '/books'	
		expect(current_path).to eq('/books')

		visit "/"
	    click_link('Log In')

	    fill_in("user[username]", :with => "user")
	    fill_in("user[password]", :with => "password")
		click_button('Sign In')	

		visit '/books/1'	
		expect(page).to have_link('Add Book')
	end

	it 'book show page has author, genre and title' do 
		visit "/"
	    click_link('Log In')

	    fill_in("user[username]", :with => "user")
	    fill_in("user[password]", :with => "password")
		click_button('Sign In')	

		visit '/books/1'
		expect(page).to have_content(@book.genre.title.titleize)
		expect(page).to have_content(@book.author.name.titleize)
		expect(page).to have_content(@book.title.titleize)	
	end
end