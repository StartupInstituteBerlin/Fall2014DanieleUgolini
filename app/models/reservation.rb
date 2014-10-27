class Reservation < ActiveRecord::Base
	belongs_to :restaurant

	after_create :send_notification

	def send_notification
		ReservationMailer.new_reservation(self).deliver
	end
end
