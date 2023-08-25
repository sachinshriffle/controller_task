class User < ApplicationRecord
	has_one :address , as: :addressable, dependent: :destroy
	validates_uniqueness_of :name , scope: [:mobile_number,:add]
	belongs_to :course
end
