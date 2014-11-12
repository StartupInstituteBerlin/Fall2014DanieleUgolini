class Restaurant < ActiveRecord::Base
	validates :name, presence: true,
                    length: { minimum: 3 }

	validates :name, :description, :full_address, :phone_number, presence: true 

	belongs_to :user
	has_many :reservations

	accepts_nested_attributes_for :reservations        
end
