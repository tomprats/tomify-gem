class @Form
  copy: ->
    form = new Form(@layout)
    form.fields = (field.copy(form) for field in @fields)
    form.models = @models
    form
  constructor: (layout) ->
    @layout = layout
    @fields = []
    @models = []
  value: (name) ->
    @changes.get(name) ? @record.get(name) ? ""
  onChange: (name, e) ->
    change = {}
    change[name] = switch e.target.type
      when "checkbox" then e.target.checked
      when "file" then e.target.files[0]
      else e.target.value
    return @changes.remove(name) if @record.get(name) == change[name]
    @changes.merge(change)
  options: (props) ->
    options = []
    options.push { value: "", name: "None" } if props.allowBlank
    for record in @component.state[props.model.lowercase]
      options.push { value: record.id, name: record.name }
    options
  add: (name, type, options = {}) ->
    options = $.extend { type: type, name: name, form: @ }, options
    @fields.push Field.build(options)
    @models.push options.model if options.model
  setComponent: (component) ->
    @component = component
    @record = component.store.findOrCreate "Record", {}
    @changes = component.store.findOrCreate "Changes", {}
    @stores = { record: @record, changes: @changes }
    component.followModels.push model for model in @models
    component.followStores.push BuildObject(key, value) for key, value of @stores
    @
  setDefaultValues: ->
    record = @record.get()
    changes = {}
    for field in @fields
      name = field.props.name
      value = null
      continue if record[name]?
      switch field.props.type
        when "checkbox"
          value = true
        when "select"
          continue if field.allowBlank
          options = field.props.options?() || field.props.options
          value = options[0]?.value
      continue unless value?
      changes[name] = value
    @changes.set(changes)
  renderField: (field) ->
    FieldComponent = Form.Field[field.props.type.capitalize] || Form.Field.Default
    if @layout == "horizontal"
      <div key={field.props.name} className="form-group">
        <label className="col-sm-2 control-label" htmlFor={field.props.name}>
          {field.props.name.titleize}
        </label>
        <div className="col-sm-10">
          <FieldComponent {...field.props} />
        </div>
      </div>
    else
      <div key={field.props.name} className="form-group">
        <FieldComponent {...field.props} />
      </div>
  render: ->
    @renderField(field) for field in @fields
