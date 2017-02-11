module Tomify::Concerns::Upload
  extend ActiveSupport::Concern

  included do
    mount_uploader :file, Tomify::FileUploader

    before_validation :set_model
    before_validation :validate_content_type, on: :update, if: :content_type_changed?

    validates_presence_of :uuid, :name, :file, :size, :content_type
    validates_uniqueness_of :uuid, :name

    default_scope { order(:name) }
  end

  def to_param
    uuid
  end

  class_methods do
    def admin_params
      [:uuid, :name, :file, :size, :content_type]
    end
  end

  private
  def set_model
    self.uuid ||= SecureRandom.uuid
    self.size = file.size
    self.content_type = file.content_type
  end

  def validate_content_type
    errors.add(:content_type, "cannot change")
  end
end
