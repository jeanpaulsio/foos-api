class TeamSerializer < ActiveModel::Serializer
  attributes :id, :team_name, :captain, :player

  def team_name
    "#{object.captain.handle} and #{object.player.handle}"
  end

  def captain
    object.captain.handle
  end

  def player
    object.player.handle
  end
end
