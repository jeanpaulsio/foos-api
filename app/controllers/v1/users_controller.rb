module V1
  # :nodoc:
  class UsersController < ApplicationController
    before_action :authenticate_user, except: :create

    def index
      render json: User.all
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
      if current_user.id != params[:id].to_i ||
         !current_user.authenticate(params[:user][:old_password])
        head :unauthorized
      else
        @user = User.find(params[:id])
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
