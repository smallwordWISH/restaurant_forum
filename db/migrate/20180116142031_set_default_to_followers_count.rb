class SetDefaultToFollowersCount < ActiveRecord::Migration[5.1]
  def change
    change_column :users, :followers_count, :integer, :default => 0
  end
end
