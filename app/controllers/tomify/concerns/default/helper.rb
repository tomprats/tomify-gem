module Tomify::Concerns::Default::Helper
  def setting(name)
    Tomify.setting(name)
  end

  def root_page
    Tomify.models.page.root
  end

  def page
    return @page if @page

    default_page = Tomify.models.page.default
    default_page.admin = self.class.name.include? "Admin::"
    default_page
  end
end
