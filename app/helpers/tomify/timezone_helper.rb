module Tomify::TimezoneHelper
  def self.load_config
    Rails.application.config.time_zone = Tomify.setting(:timezone)
  end
end
