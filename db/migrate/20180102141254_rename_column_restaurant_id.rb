class RenameColumnRestaurantId < ActiveRecord::Migration[5.1]
  def change
    rename_column :favorites, :restaurnt_id, :restaurant_id
  end
end
