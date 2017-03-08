module Tomify::Concerns::Api::Public
  extend ActiveSupport::Concern

  include Tomify::Concerns::Api::JSON

  def record_params
    params.require(model_param).permit(model.public_params)
  end
end
