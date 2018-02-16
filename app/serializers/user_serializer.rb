class UserSerializer < ActiveModel::Serializer
  attributes :id, :handle, :games_won,
             :games_lost, :games_played, :winning_percentage, :rating

  def rating
    format('%.3f', object.trueskill_mean)
  end
end
