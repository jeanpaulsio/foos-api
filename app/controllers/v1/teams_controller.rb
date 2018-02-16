module V1
  # :nodoc:
  class TeamsController < ApplicationController
    before_action :authenticate_user

    def index
      @teams = Team.all
      @teams = @teams.sort_by do |team|
        (team.captain.trueskill_mean + team.player.trueskill_mean) / 2.0
      end

      render json: @teams.reverse
    end

    def create
      @team = Team.new(team_params)

      if @team.save
        render json: @team, status: :created
      else
        render json: @team.errors, status: :unprocessable_entity
      end
    end

    private

    def team_params
      params.require(:team).permit(:captain_id, :player_id)
    end
  end
end
