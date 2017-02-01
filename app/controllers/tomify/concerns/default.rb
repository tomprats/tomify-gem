module Tomify
  module Concerns
    module Default
      extend ActiveSupport::Concern

      include Tomify::Concerns::Default::Helpers
      include Tomify::Concerns::Default::AuthHelpers
      include Tomify::Concerns::Default::ReactHelper

      included do
        add_flash_types :success, :info, :warning, :danger
        helper_method :app, :pages, :current_user
        before_action :check_token
      end
    end
  end
end
