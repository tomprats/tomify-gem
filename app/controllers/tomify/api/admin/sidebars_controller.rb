class Tomify::Api::Admin::SidebarsController < Tomify.controllers.admin_api
  private
  def permitted_attributes
    [:active, :name, :heading, :template, :text]
  end
end
