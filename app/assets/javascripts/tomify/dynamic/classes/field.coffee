class @Field
  @build: (options) ->
    props = { name: options.name, type: options.type }
    switch props.type
      when "checkbox"
        props.label = options.label
      when "select"
        props.allowBlank = options.allowBlank
        props.model = options.model
        props.options = []
        for option in options.options || []
          props.options.push { value: option?.value ? option, name: option?.name ? option.titleize }
    field = new Field(options)
    field.props = props
    field.setForm(options.form)
    field
  copy: (form) ->
    Field.build $.extend({}, @options, { form: form })
  constructor: (options) ->
    @options = options
  setForm: (form) ->
    @props.value = form.value.bind(form)
    @props.onChange = form.onChange.bind(form)
    @props.options = form.options.bind(form, @props) if @props.model
