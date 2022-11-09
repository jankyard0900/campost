class CreateGears < ActiveRecord::Migration[6.1]
  def change
    create_table :gears do |t|
      t.integer :customer_id, null: false
      t.integer :category_id, null: false
      t.string :name,         null: false
      t.string :price,        null: false
      t.string :brand_name,   null: false

      t.timestamps
    end
  end
end
