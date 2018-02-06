class TeamSerializer < ActiveModel::Serializer
  attributes :id, :team_name, :captain,
             :player, :games_won, :games_lost,
             :games_played, :winning_percentage

  def team_name
    "#{object.captain.handle} and #{object.player.handle}"
  end

  def captain
    object.captain.handle
  end

  def player
    object.player.handle
  end

  def games_won
    object.games_won.size
  end

  def games_lost
    object.games_lost.size
  end

  def games_played
    games_won + games_lost
  end

  def winning_percentage
    return '0%' if games_played.zero?

    "#{((games_won / games_played.to_f) * 100).round(2)}%"
  end
end
