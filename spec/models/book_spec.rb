require 'rails_helper'

RSpec.describe Book, type: :model do
  describe "class methods" do
    before do
      Author.destroy_all
      Genre.destroy_all
      Book.destroy_all

      @book = Book.create(title: "It")
      @author = Author.create(name: "Stephen King")
      @genre = Genre.create(title: "Fiction")
      @book.genre = @genre
      @book.author = @author
      @book.save
    end
  

    it "has a title" do
      @book = Book.new
      @book.title = "It"
      expect(@book.title).to eq("It")
    end

    it "belongs to a genre" do
      expect(@book.genre).to eq(@genre)
    end

    it "belongs to a author" do
      expect(@book.author).to eq(@author)
    end

    it "has many users" do 
      @user = User.create(username: "user1", password: "password")
      @user2 = User.create(username: "user2", password: "password")
      @user.books << @book 
      @user2.books << @book
      @user.save
      @user2.save
      expect(@book.users.count).to eq(2)
    end
  end
end