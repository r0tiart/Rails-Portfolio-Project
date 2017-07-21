class Author < ApplicationRecord
	has_many :books
	has_many :genres, -> {distinct} ,through: :books
end
