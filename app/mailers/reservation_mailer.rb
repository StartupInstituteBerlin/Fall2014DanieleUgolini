class ReservationMailer < ActionMailer::Base
  default from: "no-reply@restaurant.com"
  #default to: "dan.ugolini@gmail.com"

  def mandrill_client
  	@mandrill_client ||= Mandrill::API.new MANDRILL_API_KEY

  end

  def new_reservation(reservation)
    @reservation = reservation
    @user_email = reservation.restaurant.user.email
  	template_name = "new-reservation"	
  	template_content = []
  	message = {
  		to: [{email: @user_email}],
  		subject: "New Reservation for #{reservation.restaurant.name} #{reservation.request_time}",
  		merge_vars: [
  			{rcpt: "dan.ugolini@gmail.com",
  				vars: [
  					{name: "TIME", content: reservation.request_time.to_s},
  					{name: "RESERVATION_EMAIL", content: reservation.email},
  					{name: "MESSAGE", content: reservation.message}
  				]
  			}
  		]
  	}

  		mandrill_client.messages.send_template template_name, template_content, message
  end
end
