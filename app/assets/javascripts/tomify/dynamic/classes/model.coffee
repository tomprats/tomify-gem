class @Model extends Observer
  @base: Model
  @create: (namespace, options) ->
    @namespace namespace, new @(namespace, options)
  constructor: (namespace, options = {}) ->
    @name = namespace.split(".").last ? throw "Model: Requires Name"
    @param = options.param ? @name.underscore
    @prefix = namespace.split(".").first.lowercase
    @path = options.path ? @name.underscore.pluralize
    @path = "/api/#{@prefix}/#{@path}"
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
    param = @param
    basePath = @path
    (path, params) ->
      [path, params] = [params, path] if path instanceof Object
      route = basePath
      route += "/#{path}" if path
      if nest
        [params, nest] = [{}, params]
        params[param] = nest
      Request[type](route, params)
  setDefaultActions: ->
    @setAction "find", @request "get"
    @setAction "show", @request "get"
    @setAction "edit", @request "get"
    @setAction "update", @request "put", true
    @setAction "new", Request.none
    @setAction "all", @request "get"
    @setAction "where", @request "get"
    @setAction "create", @request "post", true
    @setAction "destroy", @request "delete"
