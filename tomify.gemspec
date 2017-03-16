$:.push File.expand_path("../lib", __FILE__)

require "tomify/version"

Gem::Specification.new do |s|
  s.name        = "tomify"
  s.version     = Tomify::VERSION
  s.authors     = ["Tom Prats"]
  s.email       = ["tom@tomify.me"]
  s.homepage    = "https://github.com/tomprats/tomify-gem"
  s.summary     = "Backbone for Tomify Apps"
  s.description = "Provides support for paradigms commonly used in Tomify Applications"
  s.license     = "MIT"

  s.files = Dir["{app,config,db,lib,vendor}/**/*", "MIT-LICENSE", "Rakefile", "README.md"]

  s.add_dependency "rails", "~> 5.0.0", ">= 5.0.0.1"
end
