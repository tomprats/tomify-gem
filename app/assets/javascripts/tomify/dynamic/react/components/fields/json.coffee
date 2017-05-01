Component.create "Form.Field.Json",
  onKeyChange: (key, e) ->
    changes = Object.assign {}, @props.value(@props.name)
    value = changes[key]
    delete changes[key]
    key = e.target.value
    changes[key] = value if key
    @props.onChange(@props.name, target: { value: changes })
  onValueChange: (key, e) ->
    changes = Object.assign {}, @props.value(@props.name)
    changes[key] = e.target.value
    @props.onChange(@props.name, target: { value: changes })
  render: ->
    changes = Object.assign {}, @props.value(@props.name)
    changes[""] ?= ""
    index = 0
    <div>
      {for key, value of changes
        <div key={index++} className="form-group">
          <div className="col-xs-6">
            <input placeholder="Key" className="form-control" type="text" value={key} onChange={@onKeyChange.bind(null, key)} />
          </div>
          {if key
            <div className="col-xs-6">
              <input placeholder="Value" className="form-control" type="text" value={value} onChange={@onValueChange.bind(null, key)} />
            </div>
          }
        </div>
      }
    </div>
