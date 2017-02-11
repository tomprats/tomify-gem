module Tomify::RenderHelper
  def tomify_render_for(name, options = {})
    override = "#{name}_partial".to_sym
    partial = content_for?(override) ? content_for(override) : "tomify/defaults/#{name}"
    render partial: partial
  end
end
