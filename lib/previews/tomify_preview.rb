class TomifyPreview < ActionMailer::Preview
  private
  def user
    User.find_by(email: "tom@tomify.me")
  end
end
