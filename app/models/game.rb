class Game < ApplicationRecord
  belongs_to :winning_team, class_name: 'Team', foreign_key: 'winning_team_id'
  belongs_to :losing_team,  class_name: 'Team', foreign_key: 'losing_team_id'
end
