Tomify::Engine.config.paths["db/migrate"].expanded.each do |path|
  Rails.application.config.paths["db/migrate"] << path
end
