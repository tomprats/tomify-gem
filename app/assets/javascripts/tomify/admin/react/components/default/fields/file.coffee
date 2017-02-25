Component.create "Form.Field.File",
  render: ->
    <input placeholder={@props.name.titleize} className="form-control" type="file" name={@props.name} id={@props.name} onChange={@props.onChange.bind(null, @props.name)} />
