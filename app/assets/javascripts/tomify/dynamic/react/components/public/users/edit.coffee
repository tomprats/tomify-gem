form = new Form
form.add "email", "email"
form.add "first_name", "text"
form.add "last_name", "text"
form.add "password", "password"
form.add "password_confirmation", "password"

Component.create "Public.Users.Edit",
  componentWillInitialize: ->
    @model = Model.find "Public.User"
    @store = Store.findOrCreate "Public.Users.Edit"
    @form = form.setComponent @
    @follow @model.on "update", @modelUpdate
    @follow Store.find("User").on "change", @userChange
    @userChange()
  userChange: ->
    @form.record.set Store.find("User").get()
    @form.setDefaultValues()
  modelUpdate: (response) ->
    message type: response.type, text: response.message
    Store.find("User").merge @form.changes.get() if response.type == "success"
  submit: (e) ->
    e.preventDefault()
    if @form.changes.empty()
      message type: "warning", text: "Profile was not updated"
    else
      @model.update @form.changes.get()
    false
  render: ->
    <div className="container-fluid">
      <div className="row text-center">
        <div className="col-md-4 col-md-offset-4">
          <h3>Edit Profile</h3>
          <form onSubmit={@submit}>
            {@form.render()}
            <div className="form-group">
              <input type="submit" name="commit" value="Save" className="btn btn-primary" />
            </div>
          </form>
        </div>
      </div>
    </div>
