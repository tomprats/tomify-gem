model = Model.findOrCreate "Setting"
model.columns = [
  { name: "name" },
  { name: "type", value: (r) -> r.type.split("::").last },
  { name: "value", value: (r) ->
    type = r.type.split("::").last
    return "#{r.value}" if type == "Boolean"
    r.value
  },
  { name: "updated_at", value: (r) -> r.updated_at.date() },
  { name: "actions", edit: true, destroy: true }
]

options = ["Boolean", "Json", "Text", "Uploader"]
options = ({ name: option, value: "Tomify::Setting::#{option}" } for option in options)

newForm = new Form()
newForm.add "type", "select", options: options
newForm.add "name", "text"
newForm.add "value", "text"

editForm = new Form()
editForm.add "name", "text"
editForm.add "value", "text"

Component.create "Settings.Index.Container", render: -> <Index.Container name="Setting" newForm={newForm} editForm={editForm} />
