require 'rails_helper'

RSpec.describe Friendship, type: :model do
  describe "class methods" do
  	 before do
 		User.destroy_all
 		@user = User.create(username: "user1", password: "password")
      	@user2 = User.create(username: "user2", password: "password")
    end

    it 'has a status for requested by default' do

    	@user.friends.create(friend_id: @user2.friend_id)
    	expect(@user.friendships.first.status).to eq("pending")
    end


  end
end