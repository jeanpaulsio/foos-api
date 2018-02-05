class Team < ApplicationRecord
  belongs_to :captain, class_name: 'User', foreign_key: 'captain_id'
  belongs_to :player,  class_name: 'User', foreign_key: 'player_id'
end
