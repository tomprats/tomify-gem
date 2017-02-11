class Tomify::Admin::Api::Controller < Tomify.admin_controller.constantize
  include Tomify::Concerns::Admin::JSON

  def model
    @model ||= "Tomify::#{controller_name.chomp("s").titleize}".constantize
  end
end
