module Tomify::RenderHelper
  def tomify_render_for(name, options = {})
    override = "#{name}_partial".to_sym
    partial = content_for?(override) ? content_for(override) : "tomify/defaults/#{name}"
    render partial: partial
  end

  def tomify_render(name, options = {})
    # "views/tomify/templates/default"
    # "views/tomify/templates/contact"
    # "views/templates/contact"
    # name = "templates/contact"
    # => check for app version
    # => else find tomify version
  end
end
