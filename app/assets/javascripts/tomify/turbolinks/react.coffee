$(document).on "turbolinks:before-render", ->
  ReactDOM.unmountComponentAtNode(node) for node in reactNodes
  reactNodes = []
