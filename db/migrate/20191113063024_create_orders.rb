class CreateOrders < ActiveRecord::Migration[5.2]
  def change
    create_table :orders do |t|

    	t.string :postal_code1
    	t.string :postal_code2
    	t.integer :prefecture_code
    	t.string :city
    	t.string :building
    	t.integer :total
    	t.integer :status
    	t.integer :tax_id
    	t.integer :product_id
    	t.integer :customer_id
    	t.integer :payment
    	t.integer :postage_id
    	t.integer :quantity

      t.timestamps
    end
  end
end
