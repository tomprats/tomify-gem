model = Model.findOrCreate "Sidebar"
model.columns = [
  { name: "active", value: (r) -> if r.active then "Yes" else "No" },
  { name: "name" },
  { name: "heading" },
  { name: "updated_at", value: (r) -> r.updated_at.date() },
  { name: "actions", edit: true, destroy: true }
]

model.fields = [
  { name: "active", type: "checkbox" },
  { name: "name" },
  { name: "heading" },
  { name: "text", type: "markdown" }
]

Component.create "Sidebars.Index.Container", render: -> <Index.Container name="Sidebar" />
