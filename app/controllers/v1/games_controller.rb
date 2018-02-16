module V1
  # :nodoc:
  class GamesController < ApplicationController
    def index
      render json: Game.order(created_at: :desc).limit(50)
    end

    def create
      @game = RankingService.new(game_params).execute
      ActionCable.server.broadcast 'game_channel', json_response(@game)
    end

    private

    def game_params
      params.require(:game).permit(:winning_team_id, :losing_team_id)
    end
  end
end
