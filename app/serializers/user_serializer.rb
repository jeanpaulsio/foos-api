class UserSerializer < ActiveModel::Serializer
  attributes :id, :handle, :games_won,
             :games_lost, :games_played, :winning_percentage
end
