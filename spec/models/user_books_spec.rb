require 'rails_helper'

RSpec.describe UserBook, type: :model do
  describe "class methods" do

    before do
      Author.destroy_all
      Genre.destroy_all
      Book.destroy_all
      UserBook.destroy_all

      @book = Book.create(title: "It")
      @author = Author.create(name: "Stephen King")
      @genre = Genre.create(title: "Fiction")
      @book.genre = @genre
      @book.author = @author
      @book.save

      @user = User.create(username: "user", password: "password")
      @user_book = @user.user_books.create(book_id: @book.id)
    end

    it "starts on page one" do
      expect(@user_book.page).to eq("1")
    end

    describe "#reading" do 
      it 'returns true if you are still reading' do
        expect(@user_book.reading?).to be_truthy
      end
    end

    describe "#completed" do 
      it 'returns true if you have completed reading' do
        @user_book.page = "completed"
        expect(@user_book.completed?).to be_truthy
      end
    end
  end
end