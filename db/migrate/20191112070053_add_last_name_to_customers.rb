class AddLastNameToCustomers < ActiveRecord::Migration[5.2]
  def change
    add_column :customers, :last_name, :string
    add_column :customers, :first_name, :string
    add_column :customers, :last_name_kana, :string
    add_column :customers, :first_name_kana, :string
    add_column :customers, :postal_code1, :string
    add_column :customers, :postal_code2, :string
    add_column :customers, :prefecture_code, :integer
    add_column :customers, :city, :string
    add_column :customers, :building, :string
    add_column :customers, :phone_number1, :string
    add_column :customers, :phone_number2, :string
    add_column :customers, :phone_number3, :string
    add_column :customers, :deleted_at, :datetime
   
  end
end
