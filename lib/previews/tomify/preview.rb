class Tomify::Preview < ActionMailer::Preview
  private
  def user
    Tomify.models.user.find_by(email: "tom@tomify.me")
  end
end
