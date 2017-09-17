Component.create "Form.Field.File",
  render: ->
    file = <input placeholder={@props.placeholder} className="form-control" type="file" name={@props.name} id={@props.name} onChange={@props.onChange.bind(null, @props.name)} />
    value = @props.value(@props.name)
    console.log(value)
    return file unless value.url
    name = "remove_#{@props.name}"

    <div className="row">
      <div className="col-md-6">{file}</div>
      <div className="col-md-6">
        <div className="checkbox">
          <label>
            <input type="checkbox" name={name} id={name} checked={@props.value(name)} onChange={@props.onChange.bind(null, name)} />
            <span dangerouslySetInnerHTML={{__html: "Remove #{@props.name.titleize}"}} />
          </label>
        </div>
      </div>
    </div>
