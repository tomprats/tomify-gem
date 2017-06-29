require "tomify/constantly"
require "tomify/engine"
require "tomify/version"

module Tomify
  mattr_accessor :controllers
  self.controllers = Constantly.new(
    admin: "Tomify::Admin::Controller",
    admin_api: "Tomify::Api::Admin::Controller",
    base: "TomifyController",
    public: "Tomify::Public::Controller",
    public_api: "Tomify::Api::Public::Controller"
  )

  mattr_accessor :mailers
  self.mailers = Constantly.new(
    base: "TomifyMailer",
    feedback: "Tomify::FeedbackMailer",
    user: "Tomify::UserMailer"
  )

  mattr_accessor :models
  self.models = Constantly.new(
    activity: "Tomify::Activity",
    base: "TomifyRecord",
    feedback: "Tomify::Feedback",
    page: "Tomify::Page",
    setting: "Tomify::Setting",
    sidebar: "Tomify::Sidebar",
    subscription: "Tomify::Subscription",
    token: "Tomify::Token",
    user: "Tomify::User"
  )

  mattr_accessor :previews
  self.previews = Constantly.new(
    base: "Tomify::Preview",
    feedback: "Tomify::FeedbackPreview",
    user: "Tomify::UserPreview"
  )

  mattr_accessor :uploaders
  self.uploaders = Constantly.new(
    base: "TomifyUploader",
    file: "Tomify::FileUploader",
    setting: "Tomify::SettingUploader"
  )

  def self.root
    Pathname.new Gem::Specification.find_by_name("tomify").gem_dir
  end

  def self.setting(name)
    Tomify.models.setting.find_by(name: name).try(:value)
  end
end
