class Tomify::Public::FeedbackController < Tomify.controllers.public
  def new
    render component: "Public.Feedback>New"
  end
end
