class @Model extends Observer
  @base: Model
  @create: (namespace, options) ->
    @namespace namespace, new @(namespace.split(".").last, options)
  constructor: (name, options = {}) ->
    @name = name ? throw "Model: Requires Name"
    @path = "#{Tomify.Config.basePath}/#{options.path ? @name.underscore.pluralize}"
    @singleton = options.singleton ? false
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
      path = if path then "#{basePath}/#{path}" else basePath
      if nest
        [params, nest] = [{}, params]
        params[name] = nest
      Request[type](path, params)
  setDefaultActions: ->
    @setAction "find", @request "get"
    @setAction "edit", @request "get"
    @setAction "update", @request "put", true
    return if @singleton
    @setAction "new", Request.none
    @setAction "all", @request "get"
    @setAction "where", @request "get"
    @setAction "create", @request "post", true
    @setAction "destroy", @request "delete"
