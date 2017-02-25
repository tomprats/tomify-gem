model = Model.findOrCreate "Sidebar"
model.columns = [
  { name: "active", value: (r) -> if r.active then "Yes" else "No" },
  { name: "name" },
  { name: "heading" },
  { name: "updated_at", value: (r) -> r.updated_at.date() },
  { name: "actions", edit: true, destroy: true }
]

form = new Form()
form.add "active", "checkbox"
form.add "name", "text"
form.add "heading", "text"
form.add "text", "markdown"

Component.create "Sidebars.Index.Container", render: -> <Index.Container name="Sidebar" form={form} />
