Component.create "Layout.AdminNavbar",
  followStores: ["user", pages: "navbar.admin"]
  componentWillInitialize: ->
    env = Store.find "Env"
    Store.create "Navbar.Admin", env.get().navbar.admin || []
    @follow env.on "change", -> pages.set(env.get().navbar.admin)
  render: ->
    return <div /> unless @state.user.admin
    <div className="brand-navbar navbar navbar-default center">
      <div className="container-fluid">
        <div className="navbar-header">
          <a href="/admin" className="navbar-brand visible-xs-block">Admin</a>
          <button className="navbar-toggle collapsed" data-toggle="collapse" data-target="#admin-navbar">
            <span className="icon-bar" />
            <span className="icon-bar" />
            <span className="icon-bar" />
          </button>
        </div>
        <div id="admin-navbar" className="navbar-collapse collapse">
          <ul className="nav navbar-nav">
            {for page in @state.pages
              <li key={page.name}>
                <a href="/#{page.path}">{page.name}</a>
              </li>
            }
          </ul>
        </div>
      </div>
    </div>
