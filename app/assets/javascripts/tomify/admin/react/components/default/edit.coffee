Component.create "Edit.Container",
  componentWillInitialize: ->
    @model = Model.findOrCreate @props.name
    @store = Store.findOrCreate "#{@props.name}.Edit"
    @record = @store.findOrCreate "Record", {}
    @changes = @store.findOrCreate "Changes", {}
    @followStores = { store: @store, record: @record, changes: @changes }
    @followModels = (field.model for field in @model.fields when field.model)
    context = @
    @follow @model.on "edit", (response) ->
      context.changes.set({})
      context.record.set(response.data)
      context.store.merge(show: true)
    @follow @model.on "update", (response) ->
      Store.findOrCreate("Messages").push { type: response.type, text: response.message }
    @follow @model.on "new", -> context.store.merge(show: false)
    @follow @model.on "update", (response) ->
      context.store.merge(show: false) if response.type == "success"
    @follow @model.on "destroy", -> context.store.merge(show: false)
  submit: (e) ->
    e.preventDefault()
    return @update() && false unless @changes.empty()
    Store.findOrCreate("Messages").push { type: "warning", text: "#{@model.name.titleize} was not updated" }
    false
  update: ->
    return @model.update @changes.get() if @model.singleton
    @model.update @record.get("id"), @changes.get()
  cancel: (e) ->
    e.preventDefault()
    @store.merge(show: false)
    false
  render: ->
    return <div /> unless @state.store.show
    context = @
    <div className="row">
      <div className="col-xs-12">
        <div className="panel panel-default">
          <div className="panel-heading">
            <h4>Edit {@model.name.titleize}</h4>
            <a className="btn btn-danger pull-right" href="#" onClick={@cancel}><i className="fa fa-close" /></a>
          </div>
          <div className="panel-body">
            <form className="form-horizontal" onSubmit={@submit}>
              {context.field(field) for field in @model.fields}
              <div className="col-sm-offset-2 col-sm-10">
                <input type="submit" name="commit" value="Update #{@model.name.titleize}" className="btn btn-primary btn-disabled" />
              </div>
            </form>
          </div>
        </div>
      </div>
    </div>
