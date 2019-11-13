class CreateOrders < ActiveRecord::Migration[5.2]
  def change
    create_table :orders do |t|

    	t.string :postal_code1, null: false
    	t.string :postal_code2, null: false
    	t.integer :prefecture_code, null: false
    	t.string :city, null: false
    	t.string :building, null: false
    	t.integer :total, null: false
    	t.integer :status, null: false
    	t.integer :tax_id, null: false
    	t.integer :product_id, null: false
    	t.integer :customer_id, null: false
    	t.integer :payment, null: false
    	t.integer :postage_id, null: false
    	t.integer :quantity, null: false

      t.timestamps
    end
  end
end
