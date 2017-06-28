module Tomify::Concerns::Feedback
  extend ActiveSupport::Concern

  included do
    belongs_to :user, class_name: Tomify.models.user.to_s, optional: true

    after_create :notify_admin
    after_create :notify_user

    validates_presence_of :name, :email, :subject, :message

    default_scope { order(:resolved, created_at: :desc) }
  end

  private
  def notify_admin
    Tomify.mailers.feedback.admin(self).deliver_now
  end

  def notify_user
    Tomify.mailers.feedback.user(self).deliver_now
  end
end
