module Tomify::CarrierwaveHelper
  def load_config
    return unless defined? Carrierwave
    return unless settings = Tomify.setting(:aws)

    CarrierWave.configure do |config|
      config.fog_provider = "fog/aws"
      config.storage = :fog
      config.fog_credentials = {
        provider:              "AWS",
        aws_access_key_id:     settings["access_key"],
        aws_secret_access_key: settings["secret_key"]
      }
      config.fog_directory = settings["bucket"]
    end
  end
  module_function :load_config
end
