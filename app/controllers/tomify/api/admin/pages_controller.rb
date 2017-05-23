class Tomify::Api::Admin::PagesController < Tomify.controllers.admin_api
  def permitted_attributes
    [
      :parent_id, :sidebar_id,
      :active, :root, :rank,
      :path, :name, :template,
      :title, :description,
      :cover_image, :share_image,
      :text
    ]
  end

  def serializable_options
    { include: [:parent, :sidebar] }
  end
end
