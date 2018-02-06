module V1
  # :nodoc:
  class TeamsController < ApplicationController
    before_action :authenticate_user

    def index
      render json: Team.all
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
