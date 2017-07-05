Model.create "Public.Feedback", path: "feedback"

form = new Form
form.add "name", "text"
form.add "email", "email"
form.add "subject", "text"
form.add "message", "textarea"

Component.create "Public.Feedback",
  componentWillInitialize: ->
    @model = Model.find "Public.Feedback"
    @store = Store.findOrCreate "Public.Feedback"
    @form = form.setComponent @
    @follow @model.on "create", @modelCreate
    @model.new()
    @form.changes.merge page: Store.find("Params").get("page")
  modelCreate: (response) ->
    message type: response.type, text: response.message
    @form.changes.set {} if response.type == "success"
  submit: (e) ->
    e.preventDefault()
    if @form.changes.empty()
      message type: "warning", text: "You shall not pass!"
    else
      @model.create @form.changes.get()
    false
  render: ->
    <div className="row text-center">
      <div className="dynamic-sm">
        <div>
          <h3>Feedback</h3>
          <form onSubmit={@submit}>
            {@form.render()}
            <div className="form-group">
              <input type="submit" name="commit" value="Submit" className="btn btn-primary" />
            </div>
          </form>
        </div>
      </div>
    </div>
