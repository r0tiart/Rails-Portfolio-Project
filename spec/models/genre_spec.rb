require 'rails_helper'

RSpec.describe Genre, type: :model do
  describe "class methods" do
    before do
      Author.destroy_all
      Genre.destroy_all
      Book.destroy_all

      @genre = Genre.create(title: "Fiction")
      @author = Author.create(name: "Stephen King")
      @author2 = Author.create(name: "Herman Melville")
      @book = Book.create(title:"It")
      @book2 = @genre.books.create(title: "Carrie")
      @book3 = @genre.books.create(title: "Moby Dick")

      @genre.books << @book
      @author.books << @book
      @author.books << @book2
      @author2.books << @book3
      @genre.save
    end
  

    it "has a title" do
      expect(@genre.title).to eq("Fiction")
    end

    it "has many books" do
     expect(@genre.books.count).to eq(3)
    end

    it "has many authors through books" do
     
      expect(@genre.authors.count).to eq(2)
    end

    it "shows only unqiue authors" do
      expect(@genre.authors).to contain_exactly(@author, @author2)
    end 
  end
end