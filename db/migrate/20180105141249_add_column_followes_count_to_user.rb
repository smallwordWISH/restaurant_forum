class AddColumnFollowesCountToUser < ActiveRecord::Migration[5.1]
  def change
    add_column :users, :followers_count, :integer
  end
end
