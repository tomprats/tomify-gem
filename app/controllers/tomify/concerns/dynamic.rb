module Tomify
  module Concerns
    module Dynamic
      extend ActiveSupport::Concern

      include Tomify::Concerns::Dynamic::Helpers
    end
  end
end
