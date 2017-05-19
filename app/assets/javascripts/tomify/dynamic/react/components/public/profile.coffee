Component.create "Public.Profile",
  followStores: ["user"]
  componentWillInitialize: ->
    @model = Model.find "Public.User"
    @model.setAction "show", Request.none
    @follow @model.on "show", @modelShow
    @follow @model.on "edit", @modelEdit
  modelShow: ->
    @setState(edit: false)
  modelEdit: ->
    @setState(edit: true)
  edit: (e) ->
    e.preventDefault()
    Model.findOrCreate("Public.User").edit()
  render: ->
    <div className="row text-center">
      <div className="col-md-4 col-md-offset-4">
        {if @state.edit
          <Public.Users.Edit />
        else
          <Public.Users.Show />
        }
      </div>
    </div>
