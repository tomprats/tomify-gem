Component.create "Messages.Container",
  followStores: ["messages"]
  componentWillInitialize: ->
    @store = Store.find_or_create "Messages", []
    @follow @store.on "push", -> $("body").scrollTop(0)
  remove: (i) ->
    context = @
    (e) ->
      e.preventDefault()
      context.store.remove(i)
      false
  render: ->
    context = @
    <div>
      {for message, i in @state.messages
        <div key={i} className="alert alert-#{message.type} text-center">
          {message.text}
          <a className="btn btn-danger btn-xs pull-right" href="#" onClick={context.remove(i)}><i className="fa fa-close" /></a>
        </div>
      }
    </div>
