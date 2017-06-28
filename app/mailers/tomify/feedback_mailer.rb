class Tomify::FeedbackMailer < Tomify.mailers.base
  def admin(feedback)
    @feedback = feedback

    mail to: Tomify.models.user.admin.pluck(:email), subject: "Feedback: #{@feedback.subject}"
  end

  def user(feedback)
    @feedback = feedback

    mail to: @feedback.email, subject: "Thank You!"
  end
end
