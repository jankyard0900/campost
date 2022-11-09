class CreateCampReviews < ActiveRecord::Migration[6.1]
  def change
    create_table :camp_reviews do |t|
      t.integer :camp_id,     null: false
      t.integer :customer_id, null: false
      t.float :rate,          null: false
      t.string :title,        null: false
      t.text :review,         null: false

      t.timestamps
    end
  end
end
