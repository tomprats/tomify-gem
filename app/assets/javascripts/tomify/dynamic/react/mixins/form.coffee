@FormMixin = {
  value: (field) ->
    @state.changes[field] ? @state.record[field] ? ""
  onChange: (field) ->
    context = @
    (e) ->
      change = {}
      change[field] = switch e.target.type
        when "checkbox" then e.target.checked
        when "file" then e.target.files[0]
        else e.target.value
      return context.changes.remove(field) if context.record.get(field) == change[field]
      context.changes.merge(change)
  field: (field) ->
    context = @
    <div key={field.name} className="form-group">
      <label className="col-sm-2 control-label" htmlFor={field.name}>
        {field.name.titleize}
      </label>
      <div className="col-sm-10">
        {switch field.type
          when "checkbox"
            <div className="checkbox">
              <label>
                <input type="checkbox" name={field.name} id={field.name} checked={@value(field.name)} onChange={@onChange(field.name)} />
                <span dangerouslySetInnerHTML={{__html: field.label}} />
              </label>
            </div>
          when "file"
            <input placeholder={field.name.titleize} className="form-control" type="file" name={field.name} id={field.name} onChange={@onChange(field.name)} />
          when "markdown"
            [
              <p key="pre" className="form-control-static">
                You can use <a href="https://guides.github.com/features/mastering-markdown/#examples" target="_blank">markdown syntax</a> to bedazzle the content
              </p>
              <textarea key="area" placeholder="## Example Markdown\n\nTry to **be bold** or *maybe italic*.\n\nWrite a link [to somewhere](http://tomify.me) or even embed an image with ![Some alt text](http://tomify.me/logo.jpg)." rows=5 className="form-control" type="text" name={field.name} id={field.name} value={@value(field.name)} onChange={@onChange(field.name)} />
              <p key="post" className="help-block">Drag the bottom right corner down to enlarge the box</p>
            ]
          when "select"
            options = switch
              when field.model
                { value: record.id, name: record.name } for record in context.state[field.model.lowercase]
              when field.options
                { value: option?.value ? option, name: option?.name ? option.titleize } for option in field.options
            <select className="form-control" name={field.name} id={field.name} value={@value(field.name)} onChange={@onChange(field.name)}>
              {<option key="none">None</option> if field.allow_blank}
              {for option in options
                <option key={option.value} value={option.value}>{option.name}</option>
              }
            </select>
          when "textarea"
            <textarea placeholder={field.name.titleize} className="form-control" type="text" name={field.name} id={field.name} value={@value(field.name)} onChange={@onChange(field.name)} />
          else
            <input placeholder={field.name.titleize} className="form-control" type={field.type ? "text"} name={field.name} id={field.name} value={@value(field.name)} onChange={@onChange(field.name)} />
        }
      </div>
    </div>
}
