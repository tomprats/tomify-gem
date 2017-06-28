class Tomify::Api::Admin::FeedbackController < Tomify.controllers.admin_api
  def update
    find_record
    update_record
    render json: { type: :success, data: data, message: "#{model_name} #{record.resolved ? "Resolved" : "Unresolved"}" }
  end

  private
  def permitted_attributes
    [:resolved]
  end

  def serializable_options
    { include: [user: { only: [:first_name, :last_name, :email] }] }
  end
end
