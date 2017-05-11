module Tomify::Concerns::Activity
  extend ActiveSupport::Concern

  included do
    belongs_to :trackable, polymorphic: true

    default_scope { order(created_at: :desc) }
  end

  def trackable_kind
    trackable_type.underscore.titleize
  end
end
