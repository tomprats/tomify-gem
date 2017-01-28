class UserPreview < TomifyPreview
  def invite
    UserMailer.invite(user)
  end

  def reset_password
    UserMailer.reset_password(user)
  end
end
