class Tomify::Admin::Controller < Tomify.base_controller.constantize
  include Tomify::Concerns::Admin

  before_action :require_user!, :require_admin!

  def index
    render component: "#{controller_name.capitalize}.Index.Container"
  end
end
