require "rake"

module Tomify
  class Engine < ::Rails::Engine
    rake_tasks do
      Rake::Task["db:seed"].enhance do
        load_seed
      end
    end
  end
end
