$(document).on "click", ".sign-out", (e) ->
  e.preventDefault()
  Model.find("Public.Session").destroy().then (response) ->
    window.location.replace "/" if response.type == "success"
