Component.create "Show.Container",
  componentWillInitialize: ->
    @model = Model.findOrCreate @props.name
    @store = Store.findOrCreate "#{@props.name}.Show"
    @follow @model.on "new", @hide
    @follow @model.on "create", @hide
    @follow @model.on "show", @show
    @follow @model.on "edit", @hide
    @follow @model.on "update", @hide
  show: (response) ->
    @store.merge(show: true, record: response.data)
  hide: ->
    @store.merge(show: false)
  cancel: (e) ->
    e.preventDefault()
    @store.merge(show: false)
    false
  skipField: (field, value) ->
    return true unless value?
    return true if field == "id" || field.indexOf("_id") >= 0
    return true if field.indexOf("password") >= 0
    false
  renderFields: (object) ->
    switch
      when object instanceof Array
        for field in object
          <div key={field} className="row">
            <div className="col-xs-12">
              {@renderFields field}
            </div>
          </div>
      when object instanceof Object
        for field, value of object when !@skipField(field, value)
          <div key={field} className="row">
            <label className="col-xs-3 text-right">
              {field.titleize}
            </label>
            <div className="col-xs-9">
              {@renderFields value}
            </div>
          </div>
      when Date.parse(object)
        object.date()
      else
        "#{object}"
  render: ->
    return <div /> unless @state.store.show
    <div className="row">
      <div className="col-xs-12">
        <div className="panel panel-default">
          <div className="panel-heading">
            <h4>{@model.name.titleize}</h4>
            <a className="btn btn-danger pull-right" href="#" onClick={@cancel}><i className="fa fa-close" /></a>
          </div>
          <div className="panel-body">
            {@renderFields @state.store.record}
          </div>
        </div>
      </div>
    </div>
