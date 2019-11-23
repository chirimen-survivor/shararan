class CreatePostages < ActiveRecord::Migration[5.2]
  def change
    create_table :postages do |t|
    	t.integer :ship, null: false
      t.timestamps
    end
  end
end
