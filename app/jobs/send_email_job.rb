class SendEmailJob < ActiveJob::Base
  queue_as :default

  def perform(user)
  	@user= user
  	 ReservationMailer.booking_email(book_person, owner).deliver_now
    # Do something later
  end
end
