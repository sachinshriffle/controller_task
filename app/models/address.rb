class Address < ApplicationRecord
	belongs_to :addressable , polymorphic: true
	validates :addressable_id , uniqueness: {scope: :addressable_type , message: "your address is already save"}
end
