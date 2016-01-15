class UsersController < ApplicationController
	def index
		Reservation.select(:listing_id).where(user_id: current_user.id)
	end
end