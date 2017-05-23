class Tomify::Api::Admin::UsersController < Tomify.controllers.admin_api
  before_action :not_allowed, only: [:update, :destroy]

  def not_allowed
    find_record
    if @record.email == "tom@tomify.me" || @record.id == current_user.id
      render json: { type: :danger, message: "You shall not pass" }
    end
  end

  private
  def permitted_attributes
    [:admin, :email, :first_name, :last_name]
  end

  def record_params
    attributes = super
    attributes[:invited] = true if action_name == "create"
    attributes
  end

  def serializable_options
    { methods: [:name] }
  end
end
