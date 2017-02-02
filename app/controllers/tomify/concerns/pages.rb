module Tomify::Concerns::Pages
  def show
    @page = Tomify::Page.find_by(path: params[:path]) || not_found

    render_template
  end

  def root
    @page = root_page

    render_template
  end

  private
  def render_template
    case template = @page.template
    when "default"
    end

    render "templates/#{template}", layout: true
  end
end
