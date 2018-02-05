module V1
  # :nodoc:
  class UserTeamsController < ApplicationController
    def index
      @user = User.find(params[:user_id])
      render json: @user.primary_teams.or(@user.secondary_teams)
    end
  end
end
