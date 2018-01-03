class SetDefaultToFavoriteLikeCount < ActiveRecord::Migration[5.1]
  def change
    change_column :restaurants, :favorites_count, :integer, :default => 0
    change_column :restaurants, :likes_count, :integer, :default => 0
  end
end
