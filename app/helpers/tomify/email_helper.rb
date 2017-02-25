module Tomify::EmailHelper
  def load_config
    return unless settings = Tomify.setting(:email)

    config = {
      authentication: "plain",
      enable_starttls_auto: true,
      user_name: settings["username"],
      password: settings["password"]
    }
    config[:address] = settings["address"] || "email-smtp.us-east-1.amazonaws.com"
    config[:domain] = settings["domain"] || "tomify.me"
    config[:port] = settings["port"] || "587"

    Rails.application.config.action_mailer.smtp_settings = config
  end
  module_function :load_config
end
