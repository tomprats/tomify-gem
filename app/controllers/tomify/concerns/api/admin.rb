module Tomify::Concerns::Api::Admin
  extend ActiveSupport::Concern

  include Tomify::Concerns::Api::JSON

  def record_params
    params.require(model_param).permit(model.admin_params)
  end
end
