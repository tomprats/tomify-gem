class Tomify::UserPreview < Tomify.previews.base
  def admin
    Tomify.mailers.feedback.admin(feedback)
  end

  def user
    Tomify.mailers.feedback.user(feedback)
  end

  private
  def feedback
    Tomify.models.feedback.first
  end
end
