class CreateDiscs < ActiveRecord::Migration[5.2]
  def change
    create_table :discs do |t|
      t.integer :product_id, null: false
      t.integer :sequence, null: false

      t.timestamps
    end
  end
end
