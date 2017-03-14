class Tomify::Public::UsersController < Tomify.controllers.public
  before_action :require_user!

  def edit
    render component: "Public.Users.Edit"
  end
end
