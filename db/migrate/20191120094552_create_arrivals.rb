class CreateArrivals < ActiveRecord::Migration[5.2]
  def change
    create_table :arrivals do |t|

      t.timestamps
    end
  end
end
