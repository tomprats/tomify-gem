class @Namespace
  @base: window,
  @namespace: (namespace, value) ->
    unless namespace?.length then throw "Namespace: Requires Keys"
    unless value? then throw "Namespace: Requires Value"
    keys = namespace.split(".")
    value.namespace = namespace
    scope = @base
    for key in keys when key isnt keys.last
      scope[key] ?= {}
      scope = scope[key]
    scope[keys.last] = value
    value
  @create: @namespace
  @find: (namespace) ->
    unless namespace?.length then throw "Namespace: Requires Keys"
    scope = @base
    scope = (scope ? {})[key] for key in namespace.split(".")
    scope
  @findOrCreate: (namespace, options) ->
    @find(namespace, options) || @create(namespace, options)
  findOrCreate: (namespace, options) ->
    namespace = "#{@namespace}.#{namespace}"
    @constructor.find(namespace, options) || @constructor.create(namespace, options)
