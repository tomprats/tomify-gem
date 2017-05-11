class Tomify::Api::Public::SessionsController < Tomify.controllers.public_api
  def create
    email = params[:session][:email].strip.downcase
    user = Tomify.models.user.find_by(email: email)
    if user && user.password_digest && user.authenticate(params[:session][:password])
      session[:current_user_id] = user.id
      current_user.activities.create(action: action_name, controller: controller_name)
      flash[:success] = "Welcome #{current_user.name}!"
      render json: { type: :success }
    else
      render json: { type: :warning, message: "Invalid Credentials" }
    end
  end

  def destroy
    flash[:success] = "Goodbye #{current_user.name}" if current_user
    session[:current_user_id] = nil
    render json: { type: :success }
  end
end
