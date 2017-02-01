module Tomify
  class Engine < ::Rails::Engine
    initializer "tomify.append_assets_path" do |app|
      root = Gem::Specification.find_by_name("tomify").gem_dir
      app.config.assets.paths << "#{root}/vendor/tomify/#{Rails.env}"
    end

    initializer "tomify.render_component" do |app|
      ActionController::Renderers.add :component do |name, options|
        component = react_component name, options.delete(:props)
        render options.merge(inline: component)
      end
    end
  end
end
