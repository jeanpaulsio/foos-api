module V1
  # :nodoc:
  class GamesController < ApplicationController
    def index
      render json: Game.all
    end

    def create
      @game = Game.new(game_params)

      if @game.save
        render json: @game, status: :created
      else
        render json: @game.errors, status: :unprocessable_entity
      end
    end

    private

    def game_params
      params.require(:game).permit(:winning_team_id, :losing_team_id)
    end
  end
end
