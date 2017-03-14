Model.create "Public.Session", path: "session"

form = new Form
form.add "email", "email"
form.add "password", "password"

Component.create "Public.Sessions.New",
  componentWillInitialize: ->
    @model = Model.find "Public.Session"
    @store = Store.findOrCreate "Public.Sessions.New"
    @form = form.setComponent @
    @follow @model.on "create", @modelCreate
  modelCreate: (response) ->
    return window.location.replace "/" if response.type == "success"
    message type: response.type, text: response.message
  submit: (e) ->
    e.preventDefault()
    if @form.changes.empty()
      message type: "warning", text: "You shall not pass!"
    else
      @model.create @form.changes.get()
    false
  newPassword: (e) ->
    e.preventDefault()
    Model.findOrCreate("Public.Password").new()
  render: ->
    <div>
      <h3>Sign In</h3>
      <form onSubmit={@submit}>
        {@form.render()}
        <div className="form-group">
          <input type="submit" name="commit" value="Sign In" className="btn btn-primary" />
        </div>
        <div className="form-group">
          <small>
            <a href="#" onClick={@newPassword}>Forgot Password?</a>
          </small>
        </div>
      </form>
    </div>
