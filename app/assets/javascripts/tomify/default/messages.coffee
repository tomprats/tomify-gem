@CreateMessage = (data) ->
  $("body").scrollTop(0)
  $("nav").append "<div class=\"alert alert-#{data.type} text-center\">" +
    data.message +
    "<a class=\"close-message btn btn-danger btn-xs pull-right\" href=\"#\">" +
      "<i class=\"fa fa-close\"></i>" +
    "</a>" +
  "</div>"

$(document).on "click", ".close-message", (e) ->
  e.preventDefault()
  $(@).closest(".alert").remove()
  false
