class Tomify::Api::Public::UsersController < Tomify.controllers.public_api
  before_action :require_user!, only: [:show, :update]
  before_action :not_found, only: :create, unless: "setting(:allow_signup)"

  def create
    session[:current_user_id] = Tomify.models.user.create!(record_params).id
    create_activity
    render json: { type: :success }, success: "Welcome #{current_user.name}!"
  rescue ActiveRecord::RecordInvalid => e
    render json: { type: :warning, message: e.record.errors.full_messages.join(", ") }
  end

  private
  def create_activity
    record.activities.create(action: action_name, controller: controller_name)
  end

  def destroy_record
    flash[:danger] = "Goodbye #{current_user.name}"
    create_activity
    super
  end

  def find_record
    @record = current_user
  end

  def model_name
    @model_name ||= "Profile"
  end

  def model_param
    @model_param ||= "user"
  end

  def permitted_attributes
    [:email, :first_name, :last_name, :password, :password_confirmation]
  end

  def serializable_options
    Tomify.models.user.env_serializable_options
  end

  def update_record
    super
    create_activity
  end
end
