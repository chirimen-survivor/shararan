class CreateArrivals < ActiveRecord::Migration[5.2]
  def change
    create_table :arrivals do |t|
    	t.integer :product_id
    	t.integer :quantity
    	t.integer :stock

      t.timestamps
    end
  end
end
