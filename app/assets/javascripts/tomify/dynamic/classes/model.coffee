class @Model extends Observer
  @base: Model
  @create: (namespace, options) ->
    @namespace namespace, new @(namespace.split(".").last, options)
  constructor: (name, options = {}) ->
    @name = name ? throw "Model: Requires Name"
    @path = options.path ? @name.underscore.pluralize
    @requests = {}
    @setDefaultActions()
  setAction: (name, request) ->
    requests = @requests[name] = []
    context = @
    @[name] = (args...) ->
      request.running = true
      requests.push(request)
      $.when(request(args...)).done (response) ->
        request.running = false
        context.trigger name, response
  requested: (action) -> @requests[action].length > 0
  request: (type, nest) ->
    name = @name.underscore
    basePath = @path
    (path, params) ->
      [path, params] = [params, path] if path instanceof Object
      route = "/api"
      route += if location.pathname.startsWith "/admin" then "/admin" else "/public"
      route += "/#{basePath}"
      route += "/#{path}" if path
      if nest
        [params, nest] = [{}, params]
        params[name] = nest
      Request[type](route, params)
  setDefaultActions: ->
    @setAction "find", @request "get"
    @setAction "edit", @request "get"
    @setAction "update", @request "put", true
    @setAction "new", Request.none
    @setAction "all", @request "get"
    @setAction "where", @request "get"
    @setAction "create", @request "post", true
    @setAction "destroy", @request "delete"
