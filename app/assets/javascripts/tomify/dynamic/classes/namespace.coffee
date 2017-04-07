class @Namespace
  @base: window,
  @namespace: (namespace, value) ->
    value.namespace = namespace
    @base[namespace] = value
  @public: (namespace) ->
    keys = namespace.split(".")
    scope = @base
    for key in keys when key isnt keys.last
      scope[key] ?= {}
      scope = scope[key]
    scope[keys.last] = @find namespace
  @create: @namespace
  @find: (namespace) ->
    @base[namespace]
  @findOrCreate: (namespace, options) ->
    @find(namespace) ? @create(namespace, options)
  findOrCreate: (namespace, options) ->
    namespace = "#{@namespace}.#{namespace}"
    @constructor.find(namespace) ? @constructor.create(namespace, options)
