Component.create "Form.Field.Markdown",
  render: ->
    <div>
      <p className="form-control-static">
        You can use <a href="https://guides.github.com/features/mastering-markdown/#examples" target="_blank">markdown syntax</a> to bedazzle the content
      </p>
      <textarea placeholder="## Example Markdown\n\nTry to **be bold** or *maybe italic*.\n\nWrite a link [to somewhere](http://tomify.me) or even embed an image with ![Some alt text](http://tomify.me/logo.jpg)." rows=5 className="form-control" type="text" name={@props.name} id={@props.name} value={@props.value(@props.name)} onChange={@props.onChange.bind(null, @props.name)} />
      <p className="help-block">Drag the bottom right corner down to enlarge the box</p>
    </div>
