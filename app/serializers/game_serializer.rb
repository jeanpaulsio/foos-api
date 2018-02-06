class GameSerializer < ActiveModel::Serializer
  attributes :id, :winning_team_id, :losing_team_id
end
