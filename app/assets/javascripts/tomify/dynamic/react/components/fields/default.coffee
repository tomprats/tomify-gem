Component.create "Form.Field.Default",
  render: ->
    <input placeholder={@props.placeholder} className="form-control" type={@props.type} name={@props.name} id={@props.name} value={@props.value(@props.name)} onChange={@props.onChange.bind(null, @props.name)} />
