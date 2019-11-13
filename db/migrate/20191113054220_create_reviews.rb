class CreateReviews < ActiveRecord::Migration[5.2]
  def change
    create_table :reviews do |t|
      t.float :rating
      t.string :title
      t.string :customer_id
      t.text :body
      t.integer :product_id

      t.timestamps
    end
  end
end
