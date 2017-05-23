class Tomify::Api::Admin::SidebarsController < Tomify.controllers.admin_api
  def permitted_attributes
    [:active, :name, :heading, :template, :text]
  end
end
