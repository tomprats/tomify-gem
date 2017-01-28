class Tomify::ResetPasswordsController < TomifyController
  def create
    if user = User.find_by(email: params[:email])
      UserMailer.reset_password(user).deliver_now
      render json: { type: :success, message: "Email Sent" }
    else
      render json: { type: :warning, message: "Email could not be found" }
    end
  end
end
