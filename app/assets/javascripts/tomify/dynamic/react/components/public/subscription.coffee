Model.create "Public.Subscription", path: "subscription"

Component.create "Public.Subscription",
  getInitialState: -> { email: Store.find("Params").get("email") }
  componentWillInitialize: ->
    @model = Model.find "Public.Subscription"
    @store = Store.findOrCreate "Public.Subscription"
    @follow @model.on "destroy", @modelDestroy
  modelDestroy: (response) ->
    message type: type, text: response.message unless response.type == "success"
    @setState unsubscribed: true, message: response.message
  destroy: (e) ->
    e.preventDefault()
    @model.destroy subscription: { email: @state.email }
  render: ->
    <div className="row text-center">
      <div className="dynamic-sm">
        <h3>Unsubscribe</h3>
        {if @state.unsubscribed
          <p>{@state.message}</p>
        else
          <div>
            <p>
              By clicking Submit, <strong>{@state.email}</strong> will be no longer recieve the majority of emails from {setting "name"}.
            </p>
            <a href="#" onClick={@destroy} className="btn btn-danger" data-confirm="Are you sure?">Submit</a>
          </div>
        }
      </div>
    </div>
