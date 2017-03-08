Rails.application.config.assets.paths << "#{Tomify.root}/app/assets/images/tomify"
Rails.application.config.assets.paths << "#{Tomify.root}/vendor/tomify/#{Rails.env}"

Dir.glob("#{Tomify.root.join("app", "assets", "images")}/**/*").each do |path|
  next if File.directory? path
  Rails.application.config.assets.precompile << path.split("app/assets/images/")[1]
end
