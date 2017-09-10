form = new Form
form.add "first_name", "text"
form.add "last_name", "text"
form.add "email", "email"
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
    Store.find("User").merge response.data if response.type == "success"
  submit: (e) ->
    e.preventDefault()
    if @form.changes.empty()
      message type: "warning", text: "Profile was not updated"
    else
      @model.update @form.changes.get()
    false
  show: (e) ->
    e.preventDefault()
    Model.findOrCreate("Public.User").show()
  destroy: (e) ->
    e.preventDefault()
    Model.find("Public.User").destroy().then (response) ->
      return redirect response.redirect if response.message == "Profile Deleted"
      message type: response.type, text: response.message
    false
  render: ->
    <div>
      <h3>Edit Profile</h3>
      <form onSubmit={@submit}>
        {@form.render()}
        <div className="form-group">
          <div className="btn-group">
            <input type="submit" name="commit" value="Save" className="btn btn-primary" />
            <a href="#" onClick={@show} className="btn btn-default">Back</a>
          </div>
        </div>
        <div className="form-group">
          <small>
            <a href="#{path 'subscription'}?email=#{@form.record.get 'email'}">Email Subscription</a>
            <span> | </span>
            <a href="#" onClick={@destroy} data-confirm="Are you sure you want to permanently delete your account?">Delete Account</a>
          </small>
        </div>
      </form>
    </div>
