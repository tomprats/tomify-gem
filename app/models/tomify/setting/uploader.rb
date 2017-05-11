class Tomify::Setting::Uploader < Tomify::Setting
  mount_uploader :value, Tomify.uploaders.setting
end
