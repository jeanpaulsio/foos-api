class AddColumnsToUsers < ActiveRecord::Migration[5.1]
  def change
    add_column :users, :trueskill_mean, :float, default: 25
    add_column :users, :trueskill_deviation, :float, default: 25.0 / 3.0
  end
end
