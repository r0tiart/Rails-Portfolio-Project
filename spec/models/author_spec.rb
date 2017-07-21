require 'rails_helper'

RSpec.describe Author, type: :model do
  describe "class methods" do
    before do
      Author.destroy_all
      Genre.destroy_all
      Book.destroy_all

      @author = Author.create(name: "Stephen King")
      @genre = Genre.create(title: "Fiction")
      @book = Book.create(title:"It")


    end
  

    it "has a name" do
      expect(@author.name).to eq("Stephen King")
    end

    it "has many books" do
      @genre.books << @book
      @author.books << @book
      @book2 = @author.books.create(title: "Carrie")
      @book2.genre = @genre
      @author.save
     expect(@author.books.count).to eq(2)
    end
  end
end