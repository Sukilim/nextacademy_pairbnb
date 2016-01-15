class ListingsController < ApplicationController
  before_action :set_listing, only: [:show, :edit, :update, :destroy]

	def index
		@listings = Listing.all
		@user = Listing.select(:user_id).where(params[:id])
		@user = User.select(:username).where(id: @user)
	end

	def show
		@listings = Listing.find(params[:id])
		@listing_pictures = @listings.listing_pictures.all
		@user = Listing.select(:user_id).where(params[:id])
		@user = User.select(:username).where(id: @user)
	end

	def new
		@listing = Listing.new
	end

	def create
		@listing = Listing.new(listing_params.merge(user_id: current_user.id))
		
		respond_to do |format|
     if @listing.save
       params[:listing][:picture].each do |a|
          @listing_picture = @listing.listing_pictures.create!(:picture => a)
       end
       format.html { redirect_to @listing, notice: 'Listing was successfully created.' }
     else
       format.html { render action: 'new' }
     end
   	end
 	end

def upload_images(images)
  images.each do |i|
    Cloudinary::Uploader.upload(i)
  end
end

	def edit
	end

	def update
		 super do |resource|

     end
	end

	def destroy
	end

	private

  def listing_params
    params.require(:listing).permit(:party_name, :location, :price, :description, :theme, :date, :time, :listing_id, :picture)
  end

	def set_listing
		@listing = Listing.find(params[:id])
	end

end