Component.create "Form.Field.Select",
  render: ->
    <select className="form-control" name={@props.name} id={@props.name} value={@props.value(@props.name)} onChange={@props.onChange.bind(null, @props.name)}>
      {<option key="none">None</option> if @props.allow_blank}
      {for option in @props.options?() || @props.options
        <option key={option.value} value={option.value}>{option.name}</option>
      }
    </select>
