class TomifyMailer < ActionMailer::Base
  append_view_path Rails.root.join("app", "views", "mailers")

  default from: "Tomify <notify@tomify.me>"
  layout "tomify/mailer"

  def app
    @app ||= App.default
  end
  helper_method :app
end
