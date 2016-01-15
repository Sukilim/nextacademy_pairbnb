class CreateListingPictures < ActiveRecord::Migration
  def change
    create_table :listing_pictures do |t|
      t.integer :listing_id
      t.string :picture

      t.timestamps null: false
    end
  end
end
