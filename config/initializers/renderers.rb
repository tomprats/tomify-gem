ActionController::Renderers.add :component do |name, options|
  component = react_component name, options.delete(:props)
  render options.merge(inline: component)
end
