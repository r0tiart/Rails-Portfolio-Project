class Author < ApplicationRecord
	has_many :books
	has_many :genres, -> {distinct} ,through: :books

	validates :name, uniqueness: { case_sensitive: false }
	validates :name, presence: true
end

