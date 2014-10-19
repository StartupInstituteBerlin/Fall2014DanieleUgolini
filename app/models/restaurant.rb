class Restaurant < ActiveRecord::Base
	validates :name, presence: true,
                    length: { minimum: 3 }

	validates :name, :description, :full_address, :phone_number, presence: true 

	belongs_to :owner                
end
