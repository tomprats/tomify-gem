Component.create "Public.Users.Show",
  followStores: ["user"]
  edit: (e) ->
    e.preventDefault()
    Model.findOrCreate("Public.User").edit()
  render: ->
    <div>
      <h3>Profile</h3>
      <div className="row">
        <div className="col-sm-6 text-right"><b>First Name:</b></div>
        <div className="col-sm-6 text-left">{@state.user.first_name}</div>
      </div>
      <div className="row">
        <div className="col-sm-6 text-right"><b>Last Name:</b></div>
        <div className="col-sm-6 text-left">{@state.user.last_name}</div>
      </div>
      <div className="row">
        <div className="col-sm-6 text-right"><b>Member Since:</b></div>
        <div className="col-sm-6 text-left">{@state.user.created_at.date()}</div>
      </div>
      <br />
      <a href="#" onClick={@edit} className="btn btn-primary">Edit</a>
    </div>
