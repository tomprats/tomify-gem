class Tomify::UsersController < TomifyController
  before_action :require_user!, only: [:edit, :update]
  before_action :not_found, only: :create, unless: "app.allow_signup"

  def create
    session[:current_user_id] = User.create!(user_params).id
    flash[:success] = "Welcome #{current_user.name}!"
    render json: { type: :success, message: "Welcome #{current_user.name}!" }
  rescue ActiveRecord::RecordInvalid => e
    render json: { type: :warning, message: e.record.errors.full_messages.join(", ") }
  end

  def update
    current_user.update!(user_params)
    render json: { type: :success, message: "Profile Updated" }
  rescue ActiveRecord::RecordInvalid => e
    render json: { type: :warning, message: e.record.errors.full_messages.join(", ") }
  end

  private
  def user_params
    params.require(:user).permit(
      :email, :first_name, :last_name,
      :password, :password_confirmation
    )
  end
end
