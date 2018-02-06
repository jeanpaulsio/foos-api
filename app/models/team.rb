class Team < ApplicationRecord
  belongs_to :captain, class_name: 'User', foreign_key: 'captain_id'
  belongs_to :player,  class_name: 'User', foreign_key: 'player_id'

  has_many :games_won,  class_name: 'Game', foreign_key: 'winning_team_id'
  has_many :games_lost, class_name: 'Game', foreign_key: 'losing_team_id'
end
