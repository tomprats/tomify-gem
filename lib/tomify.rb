require "tomify/engine"
require "tomify/version"

module Tomify
  mattr_accessor :base_controller
  self.base_controller = "ApplicationController"

  mattr_accessor :base_record
  self.base_record = "ApplicationRecord"
end
