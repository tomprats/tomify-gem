module Tomify
  module Generators
    class BundleGenerator < ::Rails::Generators::NamedBase
      desc "Creates a default bundle js file"
      source_root File.expand_path("../templates", __FILE__)

      def create_default
        copy_file "default.js", "config/bundles/#{file_name}.js"
      end
    end
  end
end
