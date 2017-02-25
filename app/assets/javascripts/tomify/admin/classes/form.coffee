class @Form
  copy: ->
    form = new Form
    form.fields = (field.copy(form) for field in @fields)
    form.models = @models
    form
  constructor: ->
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
  options: (model) ->
    for record in @component.state[model.lowercase]
      { value: record.id, name: record.name }
  add: (name, type, options = {}) ->
    options = $.extend { type: type, name: name, form: @ }, options
    @fields.push Field.build(options)
    @models.push options.model if options.model
  setComponent: (component) ->
    @component = component
    @record = component.store.findOrCreate "Record", {}
    @changes = component.store.findOrCreate "Changes", {}
    @stores = { record: @record, changes: @changes }
    @
  setDefaultValues: ->
    record = @record.get()
    changes = {}
    for field in @fields when field.type == "select"
      name = field.props.name
      options = field.props.options?() || field.props.options
      value = options[0]?.value
      changes[name] = value if value != record[name]
    @changes.set(changes)
  renderField: (field) ->
    FieldComponent = Form.Field[field.type.capitalize]
    <div key={field.props.name} className="form-group">
      <label className="col-sm-2 control-label" htmlFor={field.props.name}>
        {field.props.name.titleize}
      </label>
      <div className="col-sm-10">
        <FieldComponent {...field.props} />
      </div>
    </div>
  render: ->
    @renderField(field) for field in @fields
