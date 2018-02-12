class User < ApplicationRecord
  has_secure_password
  has_many :primary_teams,   class_name: 'Team', foreign_key: 'captain_id'
  has_many :secondary_teams, class_name: 'Team', foreign_key: 'player_id'

  VALID_HANDLE_REGEX = /\A[a-z\d]*\Z/i

  validates :handle, presence: true, length: { maximum: 15 },
                     format: {
                       with: VALID_HANDLE_REGEX,
                       message: 'Username must use letters and numbers only'
                     },
                     uniqueness: {
                       case_sensitive: false,
                       message: 'Username is taken'
                     }

  def self.from_token_request(request)
    handle = request.params['auth'] && request.params['auth']['handle']
    find_by(handle: handle)
  end

  def all_teams
    primary_teams + secondary_teams
  end

  def games_won
    games_won_totals = []

    all_teams.each { |team| games_won_totals << team.games_won.count }
    games_won_totals.inject(:+) || 0
  end

  def games_lost
    games_lost_totals = []

    all_teams.each { |team| games_lost_totals << team.games_lost.count }
    games_lost_totals.inject(:+) || 0
  end

  def games_played
    games_played_totals = []

    all_teams.each do |team|
      games_played_totals << team.games_won.count
      games_played_totals << team.games_lost.count
    end

    games_played_totals.inject(:+) || 0
  end

  def winning_percentage
    return 0 if games_played.nil?
    return 0 if games_played.zero?

    ((games_won / games_played.to_f) * 100).round(2)
  end
end
