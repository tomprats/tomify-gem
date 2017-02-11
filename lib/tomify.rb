require "tomify/engine"
require "tomify/version"

module Tomify
  mattr_accessor :base_controller
  self.base_controller = "ApplicationController"

  mattr_accessor :admin_controller
  self.admin_controller = "Admin::Controller"

  mattr_accessor :admin_api_controller
  self.admin_api_controller = "Admin::Api::Controller"

  mattr_accessor :base_mailer
  self.base_mailer = "ApplicationMailer"

  mattr_accessor :base_record
  self.base_record = "ApplicationRecord"

  mattr_accessor :base_uploader
  self.base_uploader = "ApplicationUploader"
end
