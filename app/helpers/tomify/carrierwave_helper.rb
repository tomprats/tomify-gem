module Tomify::CarrierwaveHelper
  def load_config
    return unless defined? Carrierwave
    return unless settings = Tomify.setting(:AWS)

    CarrierWave.configure do |config|
      config.fog_provider = "fog/aws"
      config.storage = :fog
      config.fog_credentials = {
        provider:              "AWS",
        aws_access_key_id:     settings[:ACCESS_KEY],
        aws_secret_access_key: settings[:SECRET_KEY]
      }
      config.fog_directory = settings[:AWS_BUCKET]
    end
  end
end
