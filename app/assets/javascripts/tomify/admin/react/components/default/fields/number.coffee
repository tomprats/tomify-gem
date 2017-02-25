Component.create "Form.Field.Number",
  render: ->
    <input placeholder={@props.name.titleize} className="form-control" type="number" name={@props.name} id={@props.name} value={@props.value(@props.name)} onChange={@props.onChange.bind(null, @props.name)} />
