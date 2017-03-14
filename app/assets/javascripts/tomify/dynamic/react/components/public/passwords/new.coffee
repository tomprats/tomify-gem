Model.create "Public.Password", path: "password"

form = new Form
form.add "email", "email"

Component.create "Public.Passwords.New",
  componentWillInitialize: ->
    @model = Model.find "Public.Password"
    @store = Store.findOrCreate "Public.Passwords.New"
    @form = form.setComponent @
    @follow @model.on "create", @modelCreate
  modelCreate: (response) ->
    message type: response.type, text: response.message
  submit: (e) ->
    e.preventDefault()
    if @form.changes.empty()
      message type: "warning", text: "You shall not pass!"
    else
      @model.create @form.changes.get()
    false
  newSession: (e) ->
    e.preventDefault()
    Model.findOrCreate("Public.Session").new()
  render: ->
    <div>
      <h3>Forgot Password</h3>
      <form onSubmit={@submit}>
        {@form.render()}
        <div className="form-group">
          <input type="submit" name="commit" value="Submit" className="btn btn-primary" />
        </div>
        <div className="form-group">
          <small>
            <a href="#" onClick={@newSession}>Back</a>
          </small>
        </div>
      </form>
    </div>
