module V1
  # :nodoc:
  class UsersController < ApplicationController
    before_action :authenticate_user, except: [:create, :index]

    def index
      @users = User.all
      @users = @users
        .sort_by { |u| [u.trueskill_mean, u.games_played] }
        .select  { |u| u.games_played > 10 }
      render json: @users.reverse
    end

    def create
      @user = User.new(user_params)

      if @user.save
        auth_token = Knock::AuthToken.new payload: { sub: @user.id }
        render json: auth_token, status: :created
      else
        render json: @user.errors, status: :unprocessable_entity
      end
    end

    def update
      token = request.headers['Authorization'].split.last
      id    = Knock::AuthToken.new(token: token).payload['sub']

      if !current_user.authenticate(params[:user][:old_password])
        head :unauthorized
      else
        @user = User.find(id)
        @user.update(user_params)
        render json: @user
      end
    end

    private

    def user_params
      params.require(:user).permit(:handle, :email,
                                   :password, :password_confirmation)
    end
  end
end
