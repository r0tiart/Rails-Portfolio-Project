require 'rails_helper'

RSpec.describe Genre, type: :model do
  describe "class methods" do
    before do
      # Author.destroy_all
      Genre.destroy_all
      Book.destroy_all

      # @author = Author.create(name: "Stephen King")
      @genre = Genre.create(title: "Fiction")
 
    end
  

    it "has a title" do
      expect(@genre.title).to eq("Fiction")
    end
  end
end