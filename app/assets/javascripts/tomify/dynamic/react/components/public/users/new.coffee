Model.create "Public.User", path: "user"

form = new Form
form.add "email", "email"
form.add "first_name", "text"
form.add "last_name", "text"
form.add "password", "password"
form.add "password_confirmation", "password"

Component.create "Public.Users.New",
  componentWillInitialize: ->
    @model = Model.find "Public.User"
    @store = Store.findOrCreate "Public.Users.New"
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
  render: ->
    <div>
      <h3>Sign Up</h3>
      <form onSubmit={@submit}>
        {@form.render()}
        <div className="form-group">
          <input type="submit" name="commit" value="Sign Up" className="btn btn-primary" />
        </div>
      </form>
    </div>
