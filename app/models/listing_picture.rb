class ListingPicture < ActiveRecord::Base

mount_uploader :picture, AvatarUploader

belongs_to :listing

end
