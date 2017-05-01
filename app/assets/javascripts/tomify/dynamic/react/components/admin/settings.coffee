model = Model.findOrCreate "Admin.Setting"
model.columns = [
  { name: "name" },
  { name: "public", value: (r) -> if r.public then "Yes" else "No" },
  { name: "type", value: (r) -> r.type.split("::").last },
  { name: "value", value: (r) ->
    type = r.type.split("::").last
    return "#{r.value}" if type == "Boolean"
    return "JSON" if type == "Json"
    r.value
  },
  { name: "updated_at", value: (r) -> r.updated_at.date() },
  { name: "actions", edit: true, destroy: true }
]

options = ["Boolean", "Json", "Text", "Uploader"]
options = ({ name: option, value: "Tomify::Setting::#{option}" } for option in options)

newForm = new Form "horizontal"
newForm.add "type", "select", options: options
newForm.add "public", "checkbox"
newForm.add "name", "text"
newForm.add "value", "checkbox", if: (record, changes) -> changes.type.split("::").last == "Boolean"
newForm.add "value", "text", if: (record, changes) -> changes.type.split("::").last == "Text"
newForm.add "json", "json", if: (record, changes) -> changes.type.split("::").last == "Json"

editForm = new Form "horizontal"
editForm.add "public", "checkbox"
editForm.add "name", "text"
editForm.add "value", "checkbox", if: (record) -> record.type.split("::").last == "Boolean"
editForm.add "value", "text", if: (record) -> record.type.split("::").last == "Text"
editForm.add "json", "json", if: (record) -> record.type.split("::").last == "Json"
# editForm.add "value", "json", if: (record) -> record.type.split("::").last == "Uploader"

Component.create "Admin.Settings.Index.Container", render: -> <Index.Container name="Admin.Setting" newForm={newForm} editForm={editForm} />
