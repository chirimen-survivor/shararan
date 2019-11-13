class ChangeDataReleaseDateToProduct < ActiveRecord::Migration[5.2]
  def change
    change_column :products, :release_date, :string
  end
end
