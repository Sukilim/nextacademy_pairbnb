class UsersController < ApplicationController
	def show
		@user = User.find(params[:id])
		@listings = Listing.find_by(user_id: current_user.id)
	end
end