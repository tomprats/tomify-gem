class Tomify::Public::PagesController < Tomify.controllers.public
  def show
    @page = Tomify.models.page.find_by(path: params[:path]) || not_found

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

    render "templates/#{template}", layout: true, locals: { record: @page }
  end
end
