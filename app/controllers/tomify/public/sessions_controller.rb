class Tomify::Public::SessionsController < Tomify.controllers.public
  def show
    render component: "Public.Sessions.Show"
  end
end
