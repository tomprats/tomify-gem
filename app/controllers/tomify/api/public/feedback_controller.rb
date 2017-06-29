class Tomify::Api::Public::FeedbackController < Tomify.controllers.public_api
  def create
    create_record
    render json: { type: :success, data: data, message: "Thank you for your feedback!" }
  end

  private
  def permitted_attributes
    [:name, :email, :subject, :message]
  end

  def record_params
    super.merge(user_id: current_user.try(:id))
  end
end
