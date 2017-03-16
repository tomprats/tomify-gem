module Tomify::RenderHelper
  def tomify_render_for(name, context = nil)
    override = "#{name}_partial".to_sym
    partial = content_for?(override) ? content_for(override) : name
    if lookup_context.exists?(partial, [], true)
      render partial: partial
    elsif lookup_context.exists?(partial, ["tomify/defaults"], true)
      render partial: "tomify/defaults/#{partial}"
    else
      react_component [context, name].compact.collect { |x| x.to_s.camelize }.join(".")
    end
  end
end
