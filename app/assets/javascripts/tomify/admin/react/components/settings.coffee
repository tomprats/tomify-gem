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
model.fields = [
  { name: "type", only: ["new"], type: "select", options: options },
  { name: "name" },
  { name: "value" }
]

Component.create "Settings.Index.Container", render: -> <Index.Container name="Setting" />
