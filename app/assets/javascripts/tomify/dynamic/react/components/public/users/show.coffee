Component.create "Public.Users.Show",
  followStores: ["user"]
  edit: (e) ->
    e.preventDefault()
    Model.findOrCreate("Public.User").edit()
  render: ->
    <div>
      <h3>Profile</h3>
      <div className="media text-left">
        <div className="media-body">
          <h4 className="media-heading">{@state.user.name}</h4>
          <div><b>Email:</b> {@state.user.email}</div>
          <div><b>Verified:</b> {if @state.user.verified then "Yes" else "No"}</div>
          <div><b>Member Since:</b> {@state.user.created_at.date()}</div>
        </div>
      </div>
      <br />
      <div className="row">
        <div className="btn-group">
          <a href="#" onClick={@edit} className="btn btn-primary">Edit</a>
        </div>
      </div>
    </div>
