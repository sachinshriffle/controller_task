class User < ApplicationRecord
	has_one :address , as: :addressable, dependent: :destroy
	belongs_to :course
	
	validates :name ,presence: true, uniqueness:{ scope: [:mobile_number,:age]}
	validates :mobile_number, length: {is: 10}, numericality: {only_integer: true}
	validates :age ,presence: true, comparison: {greater_than: 17}
	
end