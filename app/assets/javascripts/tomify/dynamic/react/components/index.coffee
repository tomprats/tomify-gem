Component.create "Index.Container",
  getDefaultProps: -> { length: 5 }
  getInitialState: -> { page: 1, currentRecords: [] }
  componentWillInitialize: ->
    @model = Model.findOrCreate @props.name
    @store = Store.findOrCreate "#{@props.name}.Index"
    @records = @store.findOrCreate "Records", []
    @followStores.push records: @records
    @follow @model.on "all", @modelAll
    @follow @model.on "create", @modelCreate
    @follow @model.on "update", @modelUpdate
    @follow @model.on "destroy", @modelDestroy
  componentDidMount: ->
    @model.all()
  modelAll: (response) ->
    @records.set(response.data)
    @setPage(1)
  modelCreate: (response) ->
    @model.all() if response.type == "success"
  modelUpdate: (response) ->
    @model.all() if response.type == "success"
  modelDestroy: (response) ->
    @model.all() if response.type == "danger"
  setPage: (page) ->
    finish = page * @props.length
    start = finish - @props.length
    @setState(page: page, currentRecords: @state.records[start...finish])
  actions: (record) ->
    actions = []

    for action, value of @model.actions when action != "new" && value
      switch
        when typeof value is "function"
          actions.push value(record)
        when action in ["show", "edit"]
          modelAction = @model[action]
          click = (e) ->
            e.preventDefault()
            modelAction(record.id)
          actions.push <a key={action} className="btn btn-primary btn-xs" href="#" onClick={click}>{action.titleize}</a>
        when action == "destroy"
          destroy = @model.destroy
          click = (e) ->
            e.preventDefault()
            destroy(record.id).then (response) -> message type: response.type, text: response.message
          confirm = "Are you sure you want to delete #{record.name}?"
          actions.push <a key="destroy" className="btn btn-primary btn-xs" href="#" onClick={click} data-confirm={confirm}>Delete</a>

    <td>
      <div className="btn-group">{actions}</div>
    </td>
  render: ->
    actions = @model.actions
    actions = !!Object.keys(actions).find (action) -> action != "new" && actions[action]

    <div>
      <div className="row">
        <div className="col-xs-12">
          <div className="panel panel-default">
            <div className="panel-heading">
              <h4>
                {@model.name.pluralize.titleize}
                {if @model.actions.new
                  click = (e) =>
                    e.preventDefault()
                    @model.new()
                  <a className="btn btn-primary btn-xs" href="#" onClick={click}>New</a>
                }
              </h4>
              <Pagination page={@state.page} total={@state.records.length} setPage={@setPage} length={@props.length} />
            </div>
            <div className="table-responsive">
              <table className="table table-bordered table-hover">
                <thead>
                  <tr>
                    {for field, i in @model.columns
                      <th key={i}>{field.name.titleize}</th>
                    }
                    {<th>Actions</th> if actions}
                  </tr>
                </thead>
                <tbody>
                  {for record, i in @state.currentRecords
                    <tr key={i}>
                      {for field, j in @model.columns
                        <td key={j}>{field.value?(record) ? record[field.name]}</td>
                      }
                      {@actions(record) if actions}
                    </tr>
                  }
                </tbody>
              </table>
            </div>
            <div className="panel-footer">
              <Pagination page={@state.page} total={@state.records.length} setPage={@setPage} length={@props.length} />
              <div className="clearfix" />
            </div>
          </div>
        </div>
      </div>
      {<New.Container name={@props.name} form={@props.newForm || @props.form.copy()} /> if @model.actions.new}
      {<Show.Container name={@props.name} /> if @model.actions.show}
      {<Edit.Container name={@props.name} form={@props.editForm || @props.form.copy()} /> if @model.actions.edit}
    </div>
