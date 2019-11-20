class CreateManagerContacts < ActiveRecord::Migration[5.2]
  def change
    create_table :manager_contacts do |t|

      t.timestamps
    end
  end
end
