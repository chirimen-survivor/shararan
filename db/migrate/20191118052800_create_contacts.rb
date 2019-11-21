class CreateContacts < ActiveRecord::Migration[5.2]
  def change
    create_table :contacts do |t|
    	t.string :email
    	t.string :title
    	t.text :body
    	t.text :reply_message
    	t.integer :customer_id
    	
        t.timestamps
    end
  end
end
