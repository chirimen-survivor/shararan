class CreateOtherAddresses < ActiveRecord::Migration[5.2]
  def change
    create_table :other_addresses do |t|
      t.string :last_name, null: false
      t.string :first_name, null: false
      t.string :last_name_kana, null: false
      t.string :first_name_kana, null: false
      t.string :postal_cadde1, null: false
      t.string :postal_cadde2, null: false
      t.integer :prefecture_code, null: false
      t.string :city, null: false
      t.string :building, null: false
      t.string :phone_number1, null: false
      t.string :phone_number2, null: false
      t.string :phone_number3, null: false
      t.integer :customer_id, null: false
      t.timestamps
    end
  end
end
