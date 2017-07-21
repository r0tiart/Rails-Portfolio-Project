require 'rails_helper'

RSpec.describe Author, type: :model do
  describe "class methods" do
    before do
      Author.destroy_all
      Genre.destroy_all
      Book.destroy_all

      @genre = Genre.create(title: "Fiction")
      @genre2 = Genre.create(title: "Non-Fiction")
      @author = Author.create(name: "Stephen King")
      @author2 = Author.create(name: "Herman Melville")
      @book = Book.create(title:"It")
      @book2 = @genre2.books.create(title: "Danse Macabre")
      @book3 = @genre.books.create(title: "Moby Dick")

      @genre.books << @book
      @author.books << @book
      @author.books << @book2
      @author2.books << @book3
      @author.save

    end
  

    it "has a name" do
      expect(@author.name).to eq("Stephen King")
    end

    it "has many books" do
     expect(@author.books.count).to eq(2)
    end

    it "has many genre through books" do
      expect(@author.genres.count).to eq(2)
    end

    it "shows only unqiue genre" do
      expect(@author.genres).to contain_exactly(@genre, @genre2)
    end 
  end
end