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

  s.add_dependency "rails", "~> 5.0"
  s.add_dependency "bcrypt", "~> 3.1"
  s.add_dependency "bootstrap-sass", "~> 3.3"
  s.add_dependency "carrierwave", "~> 1.0"
  s.add_dependency "coffee-rails", "~> 4.2"
  s.add_dependency "fog-aws", "~> 1.2"
  s.add_dependency "font-awesome-rails", "~> 4.7"
  s.add_dependency "haml", "~> 4.0"
  s.add_dependency "jquery-rails", "~> 4.2"
  s.add_dependency "jquery-turbolinks", "~> 2.1"
  s.add_dependency "mini_magick", "~> 4.6"
  s.add_dependency "redcarpet", "~> 3.4"
  s.add_dependency "sass-rails", "~> 5.0"
  s.add_dependency "sprockets-cjsx", "~> 0.0"
  s.add_dependency "turbolinks", "~> 5.0"
  s.add_dependency "uglifier", "~> 3.0"
end
