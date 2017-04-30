class Tomify::UserPreview < Tomify.previews.base
  def invite
    Tomify.mailers.user.invite(user)
  end

  def reset_password
    Tomify.mailers.user.reset_password(user)
  end

  def welcome
    Tomify.mailers.user.welcome(user)
  end
end
