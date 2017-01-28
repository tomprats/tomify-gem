class Tomify::UserMailer < TomifyMailer
  def invite(user)
    @user = user

    mail to: @user.email, subject: "You're Invited!"
  end

  def reset_password(user)
    @user = user

    mail to: @user.email, subject: "Reset Password"
  end
end
