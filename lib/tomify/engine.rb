module Tomify
  class Engine < ::Rails::Engine
    initializer "tomify.append_assets_path", group: :all do |app|
      root = Gem::Specification.find_by_name("tomify").gem_dir
      app.config.assets.paths << "#{root}/vendor/tomify/#{Rails.env}"
    end
  end
end
