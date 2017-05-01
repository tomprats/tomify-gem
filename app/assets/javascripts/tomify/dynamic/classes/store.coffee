class @Store extends Observer
  @base: Store
  @create: (namespace, data) ->
    @namespace namespace, new @(data)
  constructor: (data) ->
    @data = data ? {}
  set: (data) ->
    @data = data
    @trigger "change", data
    @
  merge: (data) ->
    throw "Store: Invalid Data Type" unless @isObject()
    @trigger "merge", data
    @set Object.assign({}, @get(), data)
  push: (data) ->
    throw "Store: Invalid Data Type" unless @isArray()
    @trigger "push", data
    @set @get().concat([data])
  remove: (field) ->
    throw "Store: Invalid Data Type" unless @isObject()
    @trigger "remove", data
    data = @get()
    delete data[field]
    data = (item for item in data when item?) if @isArray()
    @set data
  get: (field) ->
    throw "Store: Invalid Data Type" unless @isDefined()
    return @data if @isBoolean() || @isString()
    data = Object.assign @data.constructor(), @data
    if field then data[field] else data
  empty: ->
    return @data.length == 0 if @isArray()
    return Object.keys(@data).length == 0 if @isObject()
    @data?
  isDefined: -> @data?
  isObject: -> @data instanceof Object
  isArray: -> @data instanceof Array
  isBoolean: -> $.type(@data) == "boolean"
  isString: -> $.type(@data) == "string"
