require 'rails_helper'

RSpec.describe Genre, type: :model do
  describe "class methods" do
    before do
      Author.destroy_all
      Genre.destroy_all
      Book.destroy_all

      @author = Author.create(name: "Stephen King")
      @genre = Genre.create(title: "Fiction")
      @book = Book.create(title:"It")
    end
  

    it "has a title" do
      expect(@genre.title).to eq("Fiction")
    end

    it "has many books" do
      @genre.books << @book
      @author.books << @book
      @book2 = @genre.books.create(title: "Carrie")
      @book2.author = @author
      @genre.save
     expect(@genre.books.count).to eq(2)
    end
  end
end