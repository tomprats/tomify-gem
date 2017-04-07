Component.create "Form.Field.Textarea",
  render: ->
    <textarea placeholder={@props.placeholder} className="form-control" type="text" name={@props.name} id={@props.name} value={@props.value(@props.name)} onChange={@props.onChange.bind(null, @props.name)} />
