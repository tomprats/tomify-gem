class Tomify::Admin::Controller < Tomify.controllers.base
  before_action :require_user!, :require_admin!

  def index
    render component: "Admin.#{controller_name.capitalize}.Index.Container"
  end
end
