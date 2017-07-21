class Book < ApplicationRecord
	belongs_to :genre
	belongs_to :author

end
