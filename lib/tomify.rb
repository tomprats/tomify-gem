require "tomify/constantly"
require "tomify/engine"
require "tomify/version"

module Tomify
  mattr_accessor :controllers
  self.controllers = Constantly.new(
    base: "TomifyController",
    admin: "Tomify::Admin::Controller",
    admin_api: "Tomify::Api::Admin::Controller"
  )

  mattr_accessor :mailers
  self.mailers = Constantly.new(
    base: "TomifyMailer",
    preview: "TomifyPreview"
  )

  mattr_accessor :models
  self.models = Constantly.new(
    base: "TomifyRecord",
    page: "Tomify::Page",
    setting: "Tomify::Setting",
    user: "Tomify::User"
  )

  mattr_accessor :uploaders
  self.uploaders = Constantly.new(base: "TomifyUploader")

  def self.root
    Pathname.new Gem::Specification.find_by_name("tomify").gem_dir
  end

  def self.setting(name)
    Tomify.models.setting.find_by(name: name).try(:value)
  end
end
