module V1
  # :nodoc:
  class TeamsController < ApplicationController
    def index
      render json: Team.all
    end
  end
end
