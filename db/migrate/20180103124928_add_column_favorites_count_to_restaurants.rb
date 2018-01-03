class AddColumnFavoritesCountToRestaurants < ActiveRecord::Migration[5.1]
  def change
    add_column :restaurants, :favorites_count, :integer
    add_column :restaurants, :likes_count, :integer
  end
end
