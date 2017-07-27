class Book < ApplicationRecord
	belongs_to :genre
	belongs_to :author
	has_many :user_books
	has_many :users, through: :user_books

	validates :title, uniqueness: { case_sensitive: false }
	validates :title, presence: true

	def genre_title
		self.genre.title
	end

	def author_name
		self.author.name
	end

	def author_attributes=(author_attributes)
	  	author_attributes.each do |i, attribute| 
	  		if !attribute.blank?
	  			author = Author.find_or_create_by(attribute)
				self.author = tag 	
			end	
		end
  	end

  	def genre_attributes=(genre_attributes)
  		genre_attributes.each do |i, attribute|
  			if !attribute.blank?
	  			genre = Genre.find_or_create_by(attribute)
				self.genre = genre 	
			end	
		end
  	end
end
