class Tomify::SessionsController < TomifyController
  def create
    email = params[:user][:email].strip.downcase
    user = User.find_by(email: email)
    if user && user.password_digest && user.authenticate(params[:user][:password])
      session[:current_user_id] = user.id
      flash[:success] = "Welcome #{current_user.name}!"
      render json: { type: :success, message: "Welcome #{current_user.name}!" }
    else
      render json: { type: :warning, message: "Invalid Credentials" }
    end
  end

  def destroy
    flash[:success] = "Goodbye #{current_user.name}" if current_user
    session[:current_user_id] = nil
    redirect_to root_path
  end
end
