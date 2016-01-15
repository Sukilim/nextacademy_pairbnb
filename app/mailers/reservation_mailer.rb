class ReservationMailer < ApplicationMailer
	def booking_email(user, host)
		@host = host
		@user= user

		mail(to: "sukilimfonxin@hotmail.com", subject: "You have received a booking")
	end
end
