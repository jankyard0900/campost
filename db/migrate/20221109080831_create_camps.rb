class CreateCamps < ActiveRecord::Migration[6.1]
  def change
    create_table :camps do |t|
      t.integer  :customer_id,        null: false
      t.integer  :area_id,            null: false
      t.string   :name,               null: false
      t.string   :address,            null: false
      t.text     :access_method,      null: false
      t.text     :parking,            null: false
      t.text     :vehicle,            null: false
      t.text     :close_facilities,   null: false
      t.text     :hot_spring,         null: false
      t.text     :in_site_facilities, null: false
      t.text     :fee_information,    null: false

      t.timestamps
    end
  end
end
