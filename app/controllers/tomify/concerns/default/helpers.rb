module Tomify
  module Concerns
    module Default
      module Helpers
        def app
          @app ||= App.default
        end

        def pages
          @active_pages ||= Page.active
        end
      end
    end
  end
end
