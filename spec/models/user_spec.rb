require 'rails_helper'

RSpec.describe Book, type: :model do
  describe "class methods" do
    before do
      # Author.destroy_all
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
  end
end