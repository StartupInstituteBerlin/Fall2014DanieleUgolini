class Reservation < ActiveRecord::Base
	belongs_to :restaurant

	after_create :send_notification

	after_initialize :defaults

	def defaults
    self.status ||= 'pending'
  end

	def send_notification
		ReservationMailer.new_reservation(self).deliver
	end
end
