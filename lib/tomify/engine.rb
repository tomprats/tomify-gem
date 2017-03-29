require "rake"

skip = ["fog-aws"]
Gem.loaded_specs["tomify"].dependencies.each do |d|
  require d.name unless d.name.in? skip
end

module Tomify
  class Engine < ::Rails::Engine
    rake_tasks do
      Rake::Task["db:seed"].enhance do
        load_seed
      end
    end
  end
end
