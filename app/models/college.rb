class College < ApplicationRecord
	has_many :courses , dependent: :destroy
	has_one :address, as: :addressable , dependent: :destroy

	validates :college_name , presence: true , uniqueness: { scope: :city, message: "College Name Can't Same Within City"}
	validates :city , presence: true
	after_save :commit_message

	def self.search(city)
		Course.joins(:college).where("city=?",city).pluck(:course_name)
	end

	private 
	def commit_message
		puts "Information Saved Successfully!"
	end
end
