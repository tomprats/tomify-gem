class Tomify::Api::Admin::UploadsController < Tomify.controllers.admin_api
  def permitted_attributes
    [:uuid, :name, :file, :size, :content_type]
  end
end
