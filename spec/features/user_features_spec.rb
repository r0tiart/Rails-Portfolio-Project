require 'rails_helper'

describe 'Feature Test: User', :type => :feature do 

	it 'successfully signs up as non-admin' do
	    visit '/'
	    expect(current_path).to eq('/users/new')
	    user_signup
	    expect(current_path).to eq('/users/1')
	end
  
end