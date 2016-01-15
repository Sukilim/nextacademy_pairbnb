class User < ActiveRecord::Base

  mount_uploader :avatar, AvatarUploader
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable,
         :omniauthable, :omniauth_providers => [:facebook]

  include PgSearch
  pg_search_scope :search, against: [:username, :email],
    using: {tsearch: {dictionary: "english"}}
  
  has_many :listings, dependent: :destroy
  has_many :reservations, dependent: :destroy

	def self.from_omniauth(auth)
	  where(provider: auth.provider, uid: auth.uid).first_or_create do |user|
	    user.email = auth.info.email
	    user.password = Devise.friendly_token[0,20]
	    user.username = auth.info.name   # assuming the user model has a name
	  end
	end

	def self.new_with_session(params, session)
    super.tap do |user|
      if data = session["devise.facebook_data"] && session["devise.facebook_data"]["extra"]["raw_info"]
        user.email = data["email"] if user.email.blank?
      end
    end
  end

  def to_s
    "#{username}"
  end

  def self.text_search(query)
    if query.present?
      search(query)
    else
      scoped
    end
  end
end
