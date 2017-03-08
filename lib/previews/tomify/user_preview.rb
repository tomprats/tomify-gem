class UserPreview < Tomify.mailers.preview
  def invite
    Tomify::UserMailer.invite(user)
  end

  def reset_password
    Tomify::UserMailer.reset_password(user)
  end
end
