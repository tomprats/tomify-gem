module Tomify::Concerns::Subscription
  extend ActiveSupport::Concern

  included do
    has_many :activities, class_name: Tomify.models.activity.to_s, as: :trackable

    scope :active, -> { where(active: true) }
    scope :inactive, -> { where(active: false) }
  end

  def inactive
    !active
  end
end
