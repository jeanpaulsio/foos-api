module V1
  # :nodoc:
  class GamesController < ApplicationController
    def index
      render json: Game.all
    end
  end
end
