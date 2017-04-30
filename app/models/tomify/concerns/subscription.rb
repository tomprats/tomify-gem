module Tomify::Concerns::Subscription
  extend ActiveSupport::Concern

  included do
    scope :active, -> { where(active: true) }
    scope :inactive, -> { where(active: false) }
  end

  def inactive
    !active
  end
end
