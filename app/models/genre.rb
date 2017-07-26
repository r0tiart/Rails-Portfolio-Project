class Genre < ActiveRecord::Base
	has_many :books
	has_many :authors, -> {distinct} ,through: :books


	validates :title, uniqueness: { case_sensitive: false }
	validates :title, presence: true

end