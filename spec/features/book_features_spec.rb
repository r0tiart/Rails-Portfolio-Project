require 'rails_helper'

describe 'Feature Test: Book', :type => :feature do 

	it 'allows non logged in user to see list of books people are reading' do
		@book = Book.create(title: "book1")
		@author = Author.create(name: "author1")
		@genre = Genre.create(title: "genre1")
		@book.author = @author
		@book.genre = @genre
		@book.save
		visit '/books'
	    expect(page).to have_content("Book1")
	    expect(page).to have_content("Author1")
	    expect(page).to have_no_button("Add Book")
	end

	it 'allows you to add book to your library if you are logged in' do
		@book = Book.create(title: "book1")
		@author = Author.create(name: "author1")
		@genre = Genre.create(title: "genre1")
		@book.author = @author
		@book.genre = @genre
		@book.save

		@user = User.create(username: "user", password: "password")
		visit "/"
	    click_link('Log In')

	    fill_in("user[username]", :with => "user")
	    fill_in("user[password]", :with => "password")
		click_button('Sign In')	

		visit '/books'	

	    expect(page).to have_link('Add Book')
	    click_link('Add Book')
	    expect(@user.books.count).to eq(1)
	end
end