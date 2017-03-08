class Tomify::Api::Admin::Controller < Tomify.controllers.admin
  include Tomify::Concerns::Api::Admin

  def model
    @model ||= "Tomify::#{controller_name.chomp("s").titleize}".constantize
  end
end
