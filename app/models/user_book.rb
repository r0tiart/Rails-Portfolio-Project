class UserBook < ApplicationRecord
	belongs_to :user 
	belongs_to :book

	validate :page_must_be_number_or_completed

	
	def reading?
		if self.page != "completed"
			true
		end
	end

	def completed?
		true if self.page == "completed"
	end

	def favorite? 
		!!favorite
	end

	private

	def page_must_be_number_or_completed
		string = page.scan(/\d+|\D+/)
		array = string.collect{|element| element.to_i}

		if array.include?(0) && self.page.downcase != "completed"
			 errors.add(:page, "must be a page number or 'completed' ")
		end
	end


end
