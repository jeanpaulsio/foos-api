class GameSerializer < ActiveModel::Serializer
  attributes :id, :winning_team, :losing_team

  def winning_team
    "#{object.winning_team.captain.handle} and #{object.winning_team.player.handle}"
  end

  def losing_team
    "#{object.losing_team.captain.handle} and #{object.losing_team.player.handle}"
  end
end
