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
  
end