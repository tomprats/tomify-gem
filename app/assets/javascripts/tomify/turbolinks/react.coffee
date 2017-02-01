@reactNodes = []

$(document).on "turbolinks:before-render", ->
  ReactDOM.unmountComponentAtNode(node) for node in window.reactNodes
  window.reactNodes = []
