model = Model.findOrCreate "Setting"
model.columns = [
  { name: "name" },
  { name: "value" },
  { name: "updated_at", value: (r) -> r.updated_at.date() },
  { name: "actions", edit: true, destroy: true }
]
model.fields = [
  { name: "name" },
  { name: "value" }
]

Component.create "Settings.Index.Container", render: -> <Index.Container name="Setting" />
