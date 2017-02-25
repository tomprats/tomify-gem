Component.create "New.Container",
  componentWillInitialize: ->
    @model = Model.findOrCreate @props.name
    @store = Store.findOrCreate "#{@props.name}.New"
    @form = @props.form.setComponent @
    @followStores = $.extend { store: @store }, @form.stores
    @followModels = @form.models
    @follow @model.on "new", @modelNew
    @follow @model.on "create", @modelCreate
    @follow @model.on "edit", @modelEdit
  modelNew: ->
    @form.record.set({})
    @form.setDefaultValues()
    @store.merge(show: true)
  modelCreate: (response) ->
    Store.findOrCreate("Messages").push { type: response.type, text: response.message }
    @store.merge(show: false) if response.type == "success"
  modelEdit: ->
    @store.merge(show: false)
  submit: (e) ->
    e.preventDefault()
    if @form.changes.empty()
      Store.findOrCreate("Messages").push { type: "warning", text: "#{@model.name.titleize} was not created" }
    else
      @model.create @form.changes.get()
    false
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
            <h4>New {@model.name.titleize}</h4>
            <a className="btn btn-danger pull-right" href="#" onClick={@cancel}><i className="fa fa-close" /></a>
          </div>
          <div className="panel-body">
            <form className="form-horizontal" onSubmit={@submit}>
              {@form.render()}
              <div className="col-sm-offset-2 col-sm-10">
                <input type="submit" name="commit" value="Create #{@model.name.titleize}" className="btn btn-primary" />
              </div>
            </form>
          </div>
        </div>
      </div>
    </div>
