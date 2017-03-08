class @Observer extends Namespace
  @base: Observer
  @create: (namespace) ->
    @namespace namespace, new @
  callbacksFor: (action) ->
    @observe ?= {}
    @observe[action] ?= $.Callbacks()
  on: (action, callback) ->
    context = @
    callback.off = -> context.off(action, callback)
    @callbacksFor(action).add callback
    callback
  off: (action, callback) ->
    @callbacksFor(action).remove(callback)
    callback
  one: (action, callback) ->
    @on action, callback
    @on action, -> callback.off()
    callback
  trigger: (action, data) ->
    @callbacksFor(action).fire(data)
    @
