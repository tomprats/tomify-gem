class Tomify::SettingUploader < Tomify.uploaders.base
  process resize_to_fit: [1000000000, 100]
end
