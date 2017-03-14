Store.create "Messages", []

Component.create "Messages.Container",
  followStores: ["messages"]
  componentWillInitialize: ->
    @store = Store.find "Messages"
    @store.push message for message in @props.messages
    @follow @store.on "push", -> $("body").scrollTop(0)
  remove: (i, e) ->
    e.preventDefault()
    @store.remove(i)
    false
  render: ->
    <div>
      {for message, i in @state.messages
        <div key={i} className="alert alert-#{message.type} text-center">
          {message.text}
          <a className="btn btn-danger btn-xs pull-right" href="#" onClick={@remove.bind(null, i)}><i className="fa fa-close" /></a>
        </div>
      }
    </div>
