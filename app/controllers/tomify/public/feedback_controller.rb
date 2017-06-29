class Tomify::Public::FeedbackController < Tomify.controllers.public
  def new
    render component: "Public.Feedback"
  end
end
