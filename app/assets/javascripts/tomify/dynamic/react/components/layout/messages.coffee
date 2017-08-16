Component.create "Layout.Messages",
  followStores: ["messages"]
  componentWillInitialize: ->
    @store = Store.create "Messages", window.env.messages
    @follow @store.on "push", (message) =>
      $("body").scrollTop(0)
      setTimeout @remove.bind(null, message), 5000
  remove: (i, e) ->
    e && e.preventDefault()
    i = @store.get().map((m) -> m.id).indexOf(i.id) if i?.id
    @store.remove(i)
    false
  render: ->
    <div>
      {for message, i in @state.messages
        <div key={i} className="alert alert-#{message.type} text-center">
          <span dangerouslySetInnerHTML={__html: message.text} />
          <a className="btn btn-danger btn-xs pull-right" href="#" onClick={@remove.bind(null, i)}><i className="fa fa-close" /></a>
        </div>
      }
    </div>
