model = Model.findOrCreate "Admin.Setting"
model.actions = { new: true, edit: true, destroy: true }
model.columns = [
  { name: "name" },
  { name: "public", value: (r) -> if r.public then "Yes" else "No" },
  { name: "type", value: (r) -> r.type.split("::").last },
  { name: "value", value: (r) ->
    return "None" unless r.value?
    switch type = r.type.split("::").last
      when "Boolean" then "#{r.value}"
      when "Uploader"
        <a href={r.value.url} target="_blank">View</a>
      when "Json" then "JSON"
      else r.value
  },
  { name: "updated_at", value: (r) -> r.updated_at.date() }
]

options = ["Boolean", "Json", "Text", "Uploader"]
options = ({ name: option, value: "Tomify::Setting::#{option}" } for option in options)

newForm = new Form "horizontal"
newForm.add "type", "select", options: options
newForm.add "public", "checkbox"
newForm.add "name", "text"
newForm.add "value", "checkbox", if: (record, changes) -> changes.type.split("::").last == "Boolean"
newForm.add "value", "textarea", if: (record, changes) -> changes.type.split("::").last == "Text"
newForm.add "value", "file", if: (record, changes) -> changes.type.split("::").last == "Uploader"
newForm.add "json", "json", if: (record, changes) -> changes.type.split("::").last == "Json"

editForm = new Form "horizontal"
editForm.add "public", "checkbox"
editForm.add "name", "text"
editForm.add "value", "checkbox", if: (record) -> record.type.split("::").last == "Boolean"
editForm.add "value", "textarea", if: (record) -> record.type.split("::").last == "Text"
editForm.add "value", "file", if: (record) -> record.type.split("::").last == "Uploader"
editForm.add "json", "json", if: (record) -> record.type.split("::").last == "Json"

Component.create "Admin.Settings.Index.Container", render: -> <Index.Container name="Admin.Setting" newForm={newForm} editForm={editForm} />
