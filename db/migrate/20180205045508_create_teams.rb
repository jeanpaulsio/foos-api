class CreateTeams < ActiveRecord::Migration[5.1]
  def change
    create_table :teams do |t|
      t.integer :captain_id
      t.integer :player_id

      t.timestamps
    end
    add_index :teams, :captain_id
    add_index :teams, :player_id
  end
end
