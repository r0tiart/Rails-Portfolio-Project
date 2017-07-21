class Genre < ActiveRecord::Base
	has_many :books
	has_many :authors, -> {distinct} ,through: :books

end