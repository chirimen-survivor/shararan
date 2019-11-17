class CreateReviews < ActiveRecord::Migration[5.2]
  def change
    create_table :reviews do |t|
      t.float :rating, null: false
      t.string :title, null: false
      t.string :customer_id, null: false
      t.text :body, null: false
      t.integer :product_id, null: false

      t.timestamps
    end
  end
end
