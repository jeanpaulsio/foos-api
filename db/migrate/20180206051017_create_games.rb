class CreateGames < ActiveRecord::Migration[5.1]
  def change
    create_table :games do |t|
      t.integer :winning_team_id
      t.integer :losing_team_id

      t.timestamps
    end
    add_index :games, :winning_team_id
    add_index :games, :losing_team_id
  end
end
