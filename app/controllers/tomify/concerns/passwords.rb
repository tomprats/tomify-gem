module Tomify::Concerns::Passwords
  def create
    if user = Tomify::User.find_by(email: params[:email])
      Tomify::UserMailer.reset_password(user).deliver_now
      render json: { type: :success, message: "Email Sent" }
    else
      render json: { type: :warning, message: "Email could not be found" }
    end
  end
end
