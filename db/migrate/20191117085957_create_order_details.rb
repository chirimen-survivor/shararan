class CreateOrderDetails < ActiveRecord::Migration[5.2]
  def change
    create_table :order_details do |t|
    	t.integer :order_id, null: false
    	t.integer :product_id, null: false
    	t.integer :subtotal, null: false
    	t.integer :quantity, null: false, default: 0

      t.timestamps
    end
  end
end
