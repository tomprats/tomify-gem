model = Model.findOrCreate "Admin.User"
model.actions = { new: true, edit: true, destroy: true }
model.columns = [
  { name: "admin", value: (r) -> if r.admin then "Yes" else "No" },
  { name: "email" },
  { name: "first_name" },
  { name: "last_name" },
  { name: "invited", value: (r) -> if r.invited then "Yes" else "No" },
  { name: "verified", value: (r) -> if r.verified then "Yes" else "No" },
  { name: "created_at", value: (r) -> r.created_at.date() },
  { name: "updated_at", value: (r) -> r.updated_at.date() }
]

form = new Form "horizontal"
form.add "admin", "checkbox"
form.add "email", "text"
form.add "first_name", "text"
form.add "last_name", "text"

Component.create "Admin.Users.Index.Container", render: -> <Index.Container name="Admin.User" form={form} />
