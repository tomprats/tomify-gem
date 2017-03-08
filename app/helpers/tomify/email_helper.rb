module Tomify::EmailHelper
  def self.load_config
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

    Rails.application.config.action_mailer.asset_host = settings["base_url"]
    Rails.application.config.action_mailer.default_url_options = { host: settings["base_url"].split("//").last }
    Rails.application.config.action_mailer.smtp_settings = config
  end
end
