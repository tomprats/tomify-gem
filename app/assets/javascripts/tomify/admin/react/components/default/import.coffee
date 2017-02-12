Component.create "Import.Container",
  componentWillInitialize: ->
    model = Model.findOrCreate @props.name
    @follow model.findOrCreate("Import").on "new", @importNew
    @follow model.on "new", @modelNew
    @follow model.on "edit", @modelEdit
  importNew: ->
    Store.findOrCreate("#{@props.name}.New").set(show: false)
    Store.findOrCreate("#{@props.name}.Edit").set(show: false)
  modelNew: ->
    Store.findOrCreate("#{@props.name}.Import.New").set(show: false)
  modelEdit: ->
    Store.findOrCreate("#{@props.name}.Import.New").set(show: false)
  render: ->
    <New.Container name="#{@props.name}.Import" />
