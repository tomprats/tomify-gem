Component.create "Form.Field.Text",
  render: ->
    <input placeholder={@props.name.titleize} className="form-control" type="text" name={@props.name} id={@props.name} value={@props.value(@props.name)} onChange={@props.onChange.bind(null, @props.name)} />
