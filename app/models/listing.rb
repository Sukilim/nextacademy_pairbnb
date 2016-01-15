class Listing < ActiveRecord::Base

	include PgSearch
  pg_search_scope :search, against: [:location],
  using: {tsearch: {dictionary: "english"}},
  associated_against: {user: :username}

  has_many :listing_pictures
  # accepts_nested_attributes_for :post_attachments
  belongs_to :user
  has_many :reservations, dependent: :destroy

  def self.text_search(query)
    if query.present?
      search(query)
    else
      scoped
    end
  end

  def to_s
    "#{username}"
  end


end
