Component.create "Index.Container",
  componentWillInitialize: ->
    @model = Model.findOrCreate @props.name
    @store = Store.findOrCreate "#{@props.name}.Index"
    @records = @store.findOrCreate "Records", []
    @followStores.push records: @records
    @follow @model.on "all", @modelAll
    @follow @model.on "create", @modelCreate
    @follow @model.on "update", @modelUpdate
    @follow @model.on "destroy", @modelDestroy
    @newForm = @props.newForm || @props.form.copy()
    @editForm = @props.editForm || @props.form.copy()
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
    @setState(page: 1, currentRecords: @state.records[(page*10 - 10)..page*10])
  new: (e) ->
    e.preventDefault()
    @model.new()
    false
  edit: (id, e) ->
    e.preventDefault()
    @model.edit(id)
    false
  destroy: (id, e) ->
    e.preventDefault()
    @model.destroy(id).then (response) ->
      message type: response.type, text: response.message
    false
  render: ->
    <div>
      <div className="row">
        <div className="col-xs-12">
          <div className="panel panel-default">
            <div className="panel-heading">
              <h4>
                {@model.name.pluralize.titleize}
                <a className="btn btn-primary btn-xs" href="#" onClick={@new}>New</a>
              </h4>
              <Pagination page="1" total={@state.records.length} setPage={@setPage} />
            </div>
            <div className="table-responsive">
              <table className="table table-bordered table-hover">
                <thead>
                  <tr>
                    {for field, i in @model.columns
                      <th key={i}>{field.name.titleize}</th>
                    }
                  </tr>
                </thead>
                <tbody>
                  {for record, i in @state.records
                    <tr key={i}>
                      {for field, j in @model.columns
                        if field.name == "actions"
                          <td key={j}>
                            {[
                              field.view && field.view(record)
                              field.view && field.edit && " | "
                              field.edit && <a key="edit" onClick={@edit.bind(null, record.id)} href="#">Edit</a>
                              field.destroy && " | "
                              field.destroy && <a key="destroy" onClick={@destroy.bind(null, record.id)} href="#" data-confirm="Are you sure you want to delete #{record.name}?">Delete</a>
                            ]}
                          </td>
                        else
                          <td key={j}>{field.value?(record) ? record[field.name]}</td>
                      }
                    </tr>
                  }
                </tbody>
              </table>
            </div>
          </div>
        </div>
      </div>
      <New.Container name={@props.name} form={@newForm} />
      <Edit.Container name={@props.name} form={@editForm} />
    </div>
