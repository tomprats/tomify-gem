$(document).on "ajax:success", "form#new-session-form", (e, response) ->
  return window.location.replace "/" if response.type == "success"
  Store.findOrCreate("Messages").push { type: response.type, text: response.message }

$(document).on "ajax:success", "form#reset-password-form", (e, response) ->
  Store.findOrCreate("Messages").push { type: response.type, text: response.message }

$(document).on "ajax:success", "form#new-user-form", (e, response) ->
  return window.location.replace "/" if response.type == "success"
  Store.findOrCreate("Messages").push { type: response.type, text: response.message }

$(document).on "ajax:success", "form#edit-user-form", (e, response) ->
  Store.findOrCreate("Messages").push { type: response.type, text: response.message }
