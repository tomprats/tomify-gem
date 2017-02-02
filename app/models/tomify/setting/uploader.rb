class Tomify::UploaderSetting < Tomify::Setting
  mount_uploader :value, Tomify::SettingUploader

  validates_presence_of :json
  validate :metadata
end
