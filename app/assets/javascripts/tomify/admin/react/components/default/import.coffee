Component.create "Import.Container",
  componentWillInitialize: ->
    model = Model.findOrCreate @props.name
    name = @props.name
    @follow model.findOrCreate("Import").on "new", (response) ->
    Store.findOrCreate("#{name}.New").set(show: false)
    Store.findOrCreate("#{name}.Edit").set(show: false)
    @follow model.on "new", (response) ->
    Store.findOrCreate("#{name}.Import.New").set(show: false)
    @follow model.on "edit", (response) ->
    Store.findOrCreate("#{name}.Import.New").set(show: false)
  render: ->
    <New.Container name="#{@props.name}.Import" />
