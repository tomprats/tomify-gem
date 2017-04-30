class Tomify::Api::Public::SubscriptionsController < Tomify.controllers.public_api
  def destroy
    subscription = Tomify.models.subscription.find_or_create_by(email: params[:subscription][:email])
    if subscription.update(active: false)
      render json: { type: :success, message: "You have been unsubscribed from #{setting(:name)}" }
    else
      render json: { type: :warning, message: "There was a problem unsubscribing you from #{setting(:name)}" }
    end
  end
end
