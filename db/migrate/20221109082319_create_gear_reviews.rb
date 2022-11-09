class CreateGearReviews < ActiveRecord::Migration[6.1]
  def change
    create_table :gear_reviews do |t|
      t.integer :gear_id,     null: false
      t.integer :customer_id, null: false
      t.float :rate,          null: false
      t.string :title,        null: false
      t.text :review,         null: false

      t.timestamps
    end
  end
end
