module V1
  # :nodoc:
  class PingController < ApplicationController
    before_action :authenticate_user

    def show
      render json: { ping: 'pong' }, status: :ok
    end
  end
end
