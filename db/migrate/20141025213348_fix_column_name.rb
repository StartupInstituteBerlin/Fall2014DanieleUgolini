class FixColumnName < ActiveRecord::Migration
  def change
  	rename_column :reservations, :restaurant, :restaurant_id
  end
end
