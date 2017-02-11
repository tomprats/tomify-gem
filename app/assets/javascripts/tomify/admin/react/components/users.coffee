model = Model.findOrCreate "User"
model.columns = [
  { name: "admin", value: (r) -> if r.admin then "Yes" else "No" },
  { name: "email" },
  { name: "first_name" },
  { name: "last_name" },
  { name: "created_at", value: (r) -> r.created_at.date() },
  { name: "updated_at", value: (r) -> r.updated_at.date() },
  { name: "actions", edit: true, destroy: true }
]

model.fields = [
  { name: "admin", type: "checkbox" },
  { name: "email" },
  { name: "first_name" },
  { name: "last_name" }
]

Component.create "Users.Index.Container", render: -> <Index.Container name="User" />
