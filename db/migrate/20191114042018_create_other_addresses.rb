class CreateOtherAddresses < ActiveRecord::Migration[5.2]
  def change
    create_table :other_addresses do |t|
      t.string :last_name
      t.string :first_name
      t.string :last_name_kana
      t.string :first_name_kana
      t.string :postal_code1
      t.string :postal_code2
      t.integer :prefecture_code
      t.string :city
      t.string :building
      t.string :phone_number1
      t.string :phone_number2
      t.string :phone_number3
      t.integer :customer_id
      t.timestamps
    end
  end
end
