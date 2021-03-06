class Tomify::Api::Admin::PagesController < Tomify.controllers.admin_api
  private
  def permitted_attributes
    [
      :parent_id, :sidebar_id,
      :active, :root, :feedback,
      :rank, :path, :name,
      :template, :title, :description,
      :cover_image, :remove_cover_image,
      :share_image, :remove_share_image,
      :text
    ]
  end

  def serializable_options
    { include: [:parent, :sidebar] }
  end
end
