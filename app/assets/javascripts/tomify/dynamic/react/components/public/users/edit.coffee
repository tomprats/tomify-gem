form = new Form
form.add "email", "email"
form.add "first_name", "text"
form.add "last_name", "text"
form.add "password", "password"
form.add "password_confirmation", "password"

Component.create "Public.Users.Edit",
  componentWillInitialize: ->
    @model = Model.findOrCreate "Public.User", path: "user"
    @store = Store.findOrCreate "Public.Users.Edit"
    @form = form.setComponent @
    @followStores = $.extend { store: @store }, @form.stores
    @followModels = @form.models
    @follow @model.on "edit", @modelEdit
    @follow @model.on "update", @modelUpdate
  componentDidMount: ->
    @model.edit()
  modelEdit: (response) ->
    @form.record.set(response.data)
    @form.setDefaultValues()
  modelUpdate: (response) ->
    Store.findOrCreate("Messages").push { type: response.type, text: response.message }
  submit: (e) ->
    e.preventDefault()
    return @update() && false unless @form.changes.empty()
    Store.findOrCreate("Messages").push { type: "warning", text: "Profile was not updated" }
    false
  update: ->
    @model.update @form.changes.get()
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
