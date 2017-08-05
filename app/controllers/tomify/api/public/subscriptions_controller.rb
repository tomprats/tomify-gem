class Tomify::Api::Public::SubscriptionsController < Tomify.controllers.public_api
  def create
    record.activities.create(action: action_name, controller: controller_name)
    if record.update(active: true)
      render json: { type: :success, data: data, message: "You have been subscribed to #{setting(:name)}" }
    else
      render json: { type: :warning, message: "There was a problem subscribing you to #{setting(:name)}" }
    end
  end

  def destroy
    record.activities.create(action: action_name, controller: controller_name)
    if record.update(active: false)
      render json: { type: :success, data: data, message: "You have been unsubscribed from #{setting(:name)}" }
    else
      render json: { type: :warning, message: "There was a problem unsubscribing you from #{setting(:name)}" }
    end
  end

  private
  def find_record
    @record ||= Tomify.models.subscription.find_or_create_by(email: params[:email] || params[:subscription][:email])
  end
end
