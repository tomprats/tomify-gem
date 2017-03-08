@reactNodes = []

$ ->
  $(".react-component").each ->
    reactNodes.push(@)
    react = $(@).data("react")
    component = Component.find(react.component)
    props = JSON.parse(react.props) if react.props
    ReactDOM.render(React.createElement(component, props), @)
