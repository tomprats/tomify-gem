Component.create "Public.Subscription",
  getInitialState: -> { subscription: { active: true, email: Store.find("Params").get("email") }}
  componentWillInitialize: ->
    @model = Model.findOrCreate "Public.Subscription"
    @store = Store.findOrCreate "Public.Subscription"
    @follow @model.on "edit", @modelUpdate
    @follow @model.on "create", @modelUpdate
    @follow @model.on "destroy", @modelUpdate
    @model.edit(Store.find("Params").get "email")
  modelUpdate: (response) ->
    message type: response.type, text: response.message if response.message
    @setState subscription: response.data if response.data
  create: (e) ->
    e.preventDefault()
    @model.create email: @state.subscription.email
  destroy: (e) ->
    e.preventDefault()
    @model.destroy email: @state.subscription.email
  render: ->
    <div className="row text-center">
      <div className="dynamic-sm">
        <h3>Subscription</h3>
        {if @state.subscription.active
          <div>
            <p>
              <strong>{@state.subscription.email}</strong> will no longer recieve the majority of emails from {setting "name"}.
            </p>
            <a href="#" onClick={@destroy} className="btn btn-danger" data-confirm="Are you sure?">Unsubscribe</a>
          </div>
        else
          <div>
            <p>
              <strong>{@state.subscription.email}</strong> will be subscribed to the emails from {setting "name"}.
            </p>
            <a href="#" onClick={@create} className="btn btn-primary">Subscribe</a>
          </div>
        }
      </div>
    </div>
