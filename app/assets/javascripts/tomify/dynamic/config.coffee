Namespace.findOrCreate "Tomify.Config", {}
Tomify.Config.basePath = ->
  path = "/api"
  path += "/admin" if location.pathname.startsWith "/admin"
  path
