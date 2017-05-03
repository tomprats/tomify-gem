module Tomify::CarrierwaveHelper
  def self.load_config
    return unless defined? CarrierWave
    return unless settings = Tomify.setting(:aws)

    descendants = CarrierWave::Uploader::Base.descendants
    descendants.push CarrierWave::Uploader::Base
    descendants.push CarrierWave
    descendants.each do |klass|
      klass.configure do |config|
        config.fog_provider = "fog/aws"
        config.fog_credentials = {
          provider:              "AWS",
          aws_access_key_id:     settings["access_key"],
          aws_secret_access_key: settings["secret_key"]
        }
        config.fog_directory = settings["bucket"]
        config.fog_public = true
        config.storage = :fog
      end
    end
  end
end
