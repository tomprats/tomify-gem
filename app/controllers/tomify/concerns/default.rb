module Tomify::Concerns::Default
  extend ActiveSupport::Concern

  include Tomify::Concerns::Default::Helpers
  include Tomify::Concerns::Default::AuthHelpers
  include Tomify::Concerns::Default::ReactHelper

  included do
    add_flash_types :success, :info, :warning, :danger
    helper_method :pages, :page, :root_page, :setting
    helper_method :current_user, :react_component
    before_action :check_token
  end
end
