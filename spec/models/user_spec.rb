require 'rails_helper'

RSpec.describe Book, type: :model do
  describe "class methods" do
    before(:each) do
      Author.destroy_all
      Genre.destroy_all
      Book.destroy_all

      @book = Book.create(title: "It")
      @author = Author.create(name: "Stephen King")
      @genre = Genre.create(title: "Fiction")
      @book2 = @genre.books.create(title: "Carrie")
      @book2.author = @author
      @book2.save

      @book.genre = @genre
      @book.author = @author
      @book.save
      @user = User.create(username: "user1", password: "password")
      @user2 = User.create(username: "user2", password: "password")

    end
  

    it "has a username" do
      expect(@user.username).to eq("user1")
    end

    it "has many books" do 
      @user.books << @book 
      @user.books << @book2
      @user.save
      expect(@user.books.count).to eq(2)
    end

    describe "#friend_request=(user)" do #submit friend request - initial friendship status should = pending by default
      it 'creates a friendship line with status of pending' do
        @user2.friend_request=(@user)
        expect(@user.friends.status).to eq("pending")
      end
    end

    describe "#friend_requests" do  #shows all pending friend request - using a search by your friend ID and status = "pending"
      it "lists all friend requests (status = pending)" do  
        @user2.friend_request(@user)
        expect(@user2.friend_requests.count).to eq(1)
      end
    end

    describe '#accept_friend_request' do #accepts the request - which should change friendship status to "friends"
      it "changings friendhip.status = friends" do  
        @user2.friend_request(@user)
        @user.accept_friend_request(@user2)
        expect(@user.friends.count).to eq(1)
      end
    end
  end
end