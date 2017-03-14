@FollowMixin = {
  getInitialSetup: ->
    @followModels ?= []
    @followStores ?= []
  getInitialState: ->
    @events ?= []
    @setupStores()
    @setupModels()
    @stores["store"] = @store if @store
    state = {}
    state[key] = store.get() for key, store of @stores
    state
  componentDidMount: ->
    context = @
    for key, store of @stores
      do (key, store) ->
        callback = ->
          state = {}
          state[key] = store.get()
          context.setState(state)
        context.events.push store.on("change", callback)
    model.all() for key, model in @models when !model.requested("all")
  componentWillUnmount: ->
    event.off() for event in @events
  follow: (event) ->
    @events ?= []
    @events.push(event)
  setupStores: ->
    @stores = @convertToHash(@followStores?() || @followStores || [])
    for key, value of @stores when not (value instanceof Store)
      store = @stores[key.lowercase] = Store.find(value.capitalize)
      throw "Component: Invalid Store (#{storeKey.capitalize})" unless store?
  setupModels: ->
    @models = @convertToHash(@followModels?() || @followModels || [])
    for key, value of @models when not (value instanceof Store)
      store = @stores[key.lowercase] = @store.findOrCreate value.capitalize, []
      model = @models[key.lowercase] = Model.findOrCreate(value)
      context = @
      do (context, store) ->
        context.follow model.on "all", (response) -> store.set(response.data)
  convertToHash: (object) ->
    return object unless object instanceof Array
    hash = {}
    for item in object
      if item instanceof Object
        key = Object.keys(item)[0]
        hash[key] = item[key]
      else
        hash[item] = item
    hash
}
