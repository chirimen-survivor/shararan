class AddFavoriteCountToProducts < ActiveRecord::Migration[5.2]
  def change
    add_column :products, :favorite_count, :integer
  end
end
