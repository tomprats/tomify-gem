class Tomify::PagesController < TomifyController
  def show
    @page = Page.find_by(path: params[:path]) || not_found

    render_template
  end

  def root
    @page = Page.root || not_found

    render_template
  end

  private
  def render_template
    send(@page.template) if respond_to?(@page.template)

    render "templates/#{@page.template}", layout: true
  end
end
