model = Model.findOrCreate "Upload"
model.columns = [
  { name: "name" },
  { name: "file", value: (r) -> <a href={r.file.url} target="_blank">View</a> },
  { name: "updated_at", value: (r) -> r.updated_at.date() },
  { name: "actions", edit: true, destroy: true }
]

form = new Form()
form.add "name", "text"
form.add "file", "file"

Component.create "Uploads.Index.Container", render: -> <Index.Container name="Upload" form={form} />
