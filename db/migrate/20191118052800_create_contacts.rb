class CreateContacts < ActiveRecord::Migration[5.2]
  def change
    create_table :contacts do |t|
    	t.string :email, null: false
    	t.string :title, null: false
    	t.text :body, null: false
    	t.text :reply_message
    	t.integer :customer_id, null: false
        t.timestamps
    end
  end
end
