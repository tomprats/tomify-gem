module Tomify::Concerns::Default::EnvHelper
  def js_env
    {
      messages: flash.collect { |key, value| { type: key, text: value }},
      navbar: {
        admin: admin_pages,
        public: public_pages
      },
      pages: pages,
      settings: public_settings,
      user: current_user
    }
  end

  def admin_pages
    [
      { name: "App", path: "admin/settings" },
      { name: "Pages", path: "admin/pages" },
      { name: "Sidebars", path: "admin/sidebars" },
      { name: "Uploads", path: "admin/uploads" },
      { name: "Users", path: "admin/users" }
    ]
  end

  def pages
    Tomify.models.page.all.as_json(only: [:active, :name, :path, :root, :template, :parent_id])
  end

  def public_pages
    Tomify.models.page.where(parent_id: nil).as_json(
      only: [:active, :name, :path, :root],
      include: [children: { only: [:active, :name, :path] }]
    )
  end

  def public_settings
    Tomify.models.setting.public.as_json(only: [:name, :value])
  end
end
