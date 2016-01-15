class CreateListings < ActiveRecord::Migration
  def change
    create_table :listings do |t|
      t.integer :user_id
      t.string :party_name
      t.string :location, index: true
      t.string :price
      t.text :description
      t.string :theme
      t.date :date
      t.string :time

    end
  end
end
