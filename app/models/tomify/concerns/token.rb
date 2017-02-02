module Tomify::Concerns::Token
  extend ActiveSupport::Concern

  included do
    belongs_to :user

    before_create :create_uuid
  end

  def to_param
    uuid
  end

  private
  def create_uuid
    self.uuid ||= SecureRandom.uuid
  end
end
