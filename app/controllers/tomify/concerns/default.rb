module Tomify::Concerns::Default
  extend ActiveSupport::Concern

  include Tomify::Concerns::Default::Helper
  include Tomify::Concerns::Default::AuthHelper
  include Tomify::Concerns::Default::EnvHelper
  include Tomify::Concerns::Default::NavbarHelper
  include Tomify::Concerns::Default::ReactHelper

  included do
    protect_from_forgery with: :exception
    add_flash_types :success, :info, :warning, :danger
    layout "tomify/layouts/application"
    helper_method :js_env, :page, :root_page, :setting
    helper_method :current_user, :react_component
    before_action :check_token
  end
end
