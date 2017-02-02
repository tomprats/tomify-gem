module Tomify::Concerns::Default::Helpers
  def setting(name)
    Tomify::Setting.find_by(name: name).try(:value)
  end

  def root_page
    Tomify::Page.root
  end

  def page
    @page || root_page
  end

  def pages
    Tomify::Page.active
  end
end
