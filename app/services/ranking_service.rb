# :nodoc:
class RankingService
  def initialize(game_params)
    @game_params = game_params

    @winning_team = Team.find(game_params[:winning_team_id])
    @losing_team  = Team.find(game_params[:losing_team_id])

    @winning_team_captain = @winning_team.captain
    @winning_team_player  = @winning_team.player

    @losing_team_captain = @losing_team.captain
    @losing_team_player  = @losing_team.player

    @winners = [@winning_team_captain, @winning_team_player]
    @losers  = [@losing_team_captain, @losing_team_player]
  end

  def execute
    @game = create_game
    update_rankings

    @game
  end

  def create_game
    @game = Game.create!(@game_params)
    @game
  end

  def update_rankings
    teams = find_trueskill_values
    calculate_trueskill(teams)
  end

  def find_trueskill_values
    teams = { winners: [], losers: [] }

    @winners.each do |winner|
      teams[:winners] << winner.trueskill_mean
      teams[:winners] << winner.trueskill_deviation
    end

    @losers.each do |loser|
      teams[:losers] << loser.trueskill_mean
      teams[:losers] << loser.trueskill_deviation
    end

    teams
  end

  def calculate_trueskill(teams)
    winners_one_mean, winner_one_deviation,
    winner_two_mean, winner_two_deviation = teams[:winners]

    loser_one_mean, loser_one_deviation,
    loser_two_mean, loser_two_deviation = teams[:losers]

    team1 = [
      Saulabs::TrueSkill::Rating.new(winners_one_mean, winner_one_deviation),
      Saulabs::TrueSkill::Rating.new(winner_two_mean, winner_two_deviation)
    ]
    team2 = [
      Saulabs::TrueSkill::Rating.new(loser_one_mean, loser_one_deviation),
      Saulabs::TrueSkill::Rating.new(loser_two_mean, loser_two_deviation)
    ]

    graph = Saulabs::TrueSkill::FactorGraph.new(team1 => 1, team2 => 2)
    graph.update_skills
    w, l = graph.teams

    winning_team_captain, winning_team_player = w
    losing_team_captain, losing_team_player   = l

    @winning_team.captain.update_attributes(
      trueskill_mean: winning_team_captain.mean,
      trueskill_deviation: winning_team_captain.deviation
    )
    @winning_team.player.update_attributes(
      trueskill_mean: winning_team_player.mean,
      trueskill_deviation: winning_team_player.deviation
    )
    @losing_team.captain.update_attributes(
      trueskill_mean: losing_team_captain.mean,
      trueskill_deviation: losing_team_captain.deviation
    )
    @losing_team.player.update_attributes(
      trueskill_mean: losing_team_player.mean,
      trueskill_deviation: losing_team_player.deviation
    )
  end
end
