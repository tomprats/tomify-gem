class TomifyMailer < ActionMailer::Base
  include Tomify::Concerns::Default::Helper

  prepend_view_path Tomify.root.join("app", "views", "tomify", "mailers")
  prepend_view_path Rails.root.join("app", "views", "mailers")

  default from: "Tomify <notify@tomify.me>"
  layout "tomify/layouts/mailer"
  helper_method :setting

  def self.mailer_name
    super.split("/").last
  end
end
