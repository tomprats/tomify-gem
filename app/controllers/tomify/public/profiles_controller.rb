class Tomify::Public::ProfilesController < Tomify.controllers.public
  before_action :require_user!

  def show
    render component: "Public.Profile"
  end
end
