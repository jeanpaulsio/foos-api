class V1::UserTokenController < Knock::AuthTokenController
  private

  def auth_params
    params.require(:auth).permit(:handle, :password)
  end
end
