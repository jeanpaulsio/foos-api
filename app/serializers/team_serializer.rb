class TeamSerializer < ActiveModel::Serializer
  attributes :id

  belongs_to :captain
  belongs_to :player
end
