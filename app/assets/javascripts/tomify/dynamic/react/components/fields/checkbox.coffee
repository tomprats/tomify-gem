Component.create "Form.Field.Checkbox",
  render: ->
    <div className="checkbox">
      <label>
        <input type="checkbox" name={@props.name} id={@props.name} checked={@props.value(@props.name)} onChange={@props.onChange.bind(null, @props.name)} />
        <span dangerouslySetInnerHTML={{__html: @props.label}} />
      </label>
    </div>
