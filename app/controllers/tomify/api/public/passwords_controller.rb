class Tomify::Api::Public::PasswordsController < Tomify.controllers.public_api
  def create
    if user = Tomify.models.user.find_by(email: params[:password][:email])
      Tomify.mailers.user.reset_password(user).deliver_now
      render json: { type: :success, message: "Email Sent" }
    else
      render json: { type: :warning, message: "Email could not be found" }
    end
  end
end
