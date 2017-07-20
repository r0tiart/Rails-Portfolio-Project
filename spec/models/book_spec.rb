require 'rails_helper'

RSpec.describe Book, type: :model do
  describe "class methods" do
    before do
      # Author.destroy_all
      Genre.destroy_all
      Book.destroy_all

      @book = Book.create(title: "It")
      # @author = Author.create(name: "Stephen King")
      @genre = Genre.create(title: "Fiction")
    end
  

    it "has a title" do
      @book = Book.new
      @book.title = "It"
      expect(@book.title).to eq("It")
    end

    it "belongs to a genre" do

      @book.genre = @genre 
      expect(@book.genre).to eq(@genre)
    end
  end
end