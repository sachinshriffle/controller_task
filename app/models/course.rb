class Course < ApplicationRecord
	belongs_to :college
	validates :course_name , uniqueness: { scope: :college_id , message:"already exist"}
	has_many :users
end
