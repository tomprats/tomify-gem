root = Gem::Specification.find_by_name("tomify").gem_dir
Rails.application.config.assets.paths << "#{root}/vendor/tomify/#{Rails.env}"
