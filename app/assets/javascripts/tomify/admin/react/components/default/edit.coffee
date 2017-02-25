Component.create "Edit.Container",
  componentWillInitialize: ->
    @model = Model.findOrCreate @props.name
    @store = Store.findOrCreate "#{@props.name}.Edit"
    @form = @props.form.setComponent @
    @followStores = $.extend { store: @store }, @form.stores
    @followModels = @form.models
    @follow @model.on "new", @modelNew
    @follow @model.on "edit", @modelEdit
    @follow @model.on "update", @modelUpdate
    @follow @model.on "destroy", @modelDestroy
  modelNew: ->
    @store.merge(show: false)
  modelEdit: (response) ->
    @form.record.set(response.data)
    @form.setDefaultValues()
    @store.merge(show: true)
  modelUpdate: (response) ->
    Store.findOrCreate("Messages").push { type: response.type, text: response.message }
    @store.merge(show: false) if response.type == "success"
  modelDestroy: ->
    @store.merge(show: false)
  submit: (e) ->
    e.preventDefault()
    return @update() && false unless @form.changes.empty()
    Store.findOrCreate("Messages").push { type: "warning", text: "#{@model.name.titleize} was not updated" }
    false
  update: ->
    return @model.update @form.changes.get() if @model.singleton
    @model.update @form.record.get("id"), @form.changes.get()
  cancel: (e) ->
    e.preventDefault()
    @store.merge(show: false)
    false
  render: ->
    return <div /> unless @state.store.show
    <div className="row">
      <div className="col-xs-12">
        <div className="panel panel-default">
          <div className="panel-heading">
            <h4>Edit {@model.name.titleize}</h4>
            <a className="btn btn-danger pull-right" href="#" onClick={@cancel}><i className="fa fa-close" /></a>
          </div>
          <div className="panel-body">
            <form className="form-horizontal" onSubmit={@submit}>
              {@form.render()}
              <div className="col-sm-offset-2 col-sm-10">
                <input type="submit" name="commit" value="Update #{@model.name.titleize}" className="btn btn-primary btn-disabled" />
              </div>
            </form>
          </div>
        </div>
      </div>
    </div>
