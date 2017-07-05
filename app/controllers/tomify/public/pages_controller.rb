class Tomify::Public::PagesController < Tomify.controllers.public
  rescue_from "ActionController::RoutingError" do |e|
    raise unless request.path[1..-1].in? ["feedback"]

    render component: "Public.#{request.path[1..-1].capitalize}"
  end

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
