class Tomify::Public::SubscriptionsController < Tomify.controllers.public
  def show
    render component: "Public.Subscription"
  end
end
