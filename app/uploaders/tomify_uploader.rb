class TomifyUploader < CarrierWave::Uploader::Base
  include CarrierWave::MiniMagick

  def store_dir
    self.class.name.downcase.chomp("uploader").chomp("image")
  end

  def filename
    "#{secure_token}.#{file.extension}" if original_filename.present?
  end

  def secure_token
    var = :"@#{mounted_as}_secure_token"
    model.instance_variable_get(var) || model.instance_variable_set(var, SecureRandom.uuid)
  end

  def image?(new_file)
    new_file.content_type.downcase.include? "image" rescue false
  end
end
