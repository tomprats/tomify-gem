module Tomify::Concerns::Default::Helpers
  def setting(name)
    Tomify.setting(name)
  end

  def root_page
    Tomify.models.page.root
  end

  def page
    @page || root_page
  end

  def pages
    Tomify.models.page.active
  end
end
