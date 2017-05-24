class Tomify::SettingUploader < Tomify.uploaders.base
  def self.width
    Proc.new do |uploader|
      uploader.setting["width"] || 1000000000
    end
  end

  def self.height
    Proc.new do |uploader|
      uploader.setting["height"] || 1000000000
    end
  end

  process resize_to_fit: [width, height]

  def setting_key
    [
      model.class.name.split("::").last.underscore,
      mounted_as, "dimensions"
    ].join("_")
  end

  def setting
    Tomify.setting(setting_key) || { "width" => width, "height" => height }
  end
end
