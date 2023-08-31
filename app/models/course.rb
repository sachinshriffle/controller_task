class Course < ApplicationRecord
	belongs_to :college
	has_many :users

	validates :course_name , uniqueness: { scope: :college_id , message:"already exist"}
end