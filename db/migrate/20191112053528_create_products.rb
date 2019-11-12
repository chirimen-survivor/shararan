class CreateProducts < ActiveRecord::Migration[5.2]
  def change
    create_table :products do |t|
      t.string :name, null: false
      t.integer :price, null: false
      t.text :image_id, null: false
      t.date :release_date, null: false
      t.integer :status, null: false, default: 0
      t.text :description, null: false
      t.integer :artist_id, null: false
      t.integer :category_id, null: false
      t.integer :company_id, null: false
      t.datetime :deleted_at
      t.timestamps
    end
  end
end
