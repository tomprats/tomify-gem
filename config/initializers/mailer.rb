if Rails.env.development?
  Rails.application.config.action_mailer.delivery_method = :test
  Rails.application.config.action_mailer.preview_path = "#{Tomify.root}/lib/previews"
end
