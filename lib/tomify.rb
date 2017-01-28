require "tomify/engine"
require "tomify/version"

module Tomify
  mattr_accessor :parent_controller
  self.parent_controller = "ApplicationController"
end
