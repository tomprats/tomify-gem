class TomifyMailer < ActionMailer::Base
  include Tomify::Concerns::Default::Helpers

  append_view_path Rails.root.join("app", "views", "mailers")

  default from: "Tomify <notify@tomify.me>"
  layout "tomify/layouts/mailer"
end
