module Tomify::Concerns::Token
  extend ActiveSupport::Concern

  included do
    belongs_to :user, class_name: Tomify.models.user

    before_create :create_uuid

    validates_uniqueness_of :name, scope: :user_id
  end

  def to_param
    uuid
  end

  private
  def create_uuid
    self.uuid ||= SecureRandom.uuid
  end
end
