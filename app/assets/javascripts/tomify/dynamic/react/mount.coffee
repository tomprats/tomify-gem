@reactNodes = []

$ ->
  $(".react-component").each ->
    reactNodes.push(@)
    component = Component.find($(@).data("component"))
    ReactDOM.render(React.createElement(component), @)
