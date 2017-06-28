model = Model.findOrCreate "Admin.Feedback", path: "feedback"
resolve = (r) ->
  click = (e) ->
    e.preventDefault()
    model.update(r.id, { resolved: !r.resolved }).then (response) ->
      message type: response.type, text: response.message
  <a key="resolve" className="btn btn-primary btn-xs" href="#" onClick={click}>
    {if r.resolved then "Unresolve" else "Resolve"}
  </a>
model.actions = { show: true, resolve: resolve, destroy: true }
model.columns = [
  { name: "name" },
  { name: "email" },
  { name: "subject" },
  { name: "resolved", value: (r) -> if r.resolved then "Yes" else "No" },
  { name: "created_at", value: (r) -> r.created_at.date() },
  { name: "updated_at", value: (r) -> r.updated_at.date() }
]

Component.create "Admin.Feedback.Index.Container", render: -> <Index.Container name="Admin.Feedback" />
