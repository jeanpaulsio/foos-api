module V1
  # :nodoc:
  class PingController < ApplicationController
    before_action :authenticate_user

    def show
      token = request.headers['Authorization'].split.last
      render json: { jwt: token }, status: :ok
    end
  end
end
