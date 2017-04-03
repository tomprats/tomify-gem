Component.create "Layout.PublicNavbar",
  followStores: ["user", pages: "Navbar.Public"]
  componentWillInitialize: ->
    env = Store.find "Env"
    Store.create "Navbar.Public", env.get().navbar.public || []
    @follow env.on "change", -> pages.set(env.get().navbar.public)
  logout: (e) ->
    e.preventDefault()
    Model.find("Public.Session").destroy().then (response) ->
      window.location.replace "/" if response.type == "success"
  link: (page) ->
    <li key={page.name}>
      <a href="/#{page.path}">{page.name}</a>
    </li>
  render: ->
    root = @state.pages.find (page) -> page.root
    <div className="navbar navbar-default center">
      <div className="container-fluid">
        <div className="navbar-header">
          <a href="/" className="navbar-brand visible-xs-block">{root?.name || "Home"}</a>
          <button className="navbar-toggle collapsed" data-toggle="collapse" data-target="#navbar">
            <span className="icon-bar" />
            <span className="icon-bar" />
            <span className="icon-bar" />
          </button>
        </div>
        <div id="navbar" className="navbar-collapse collapse">
          <ul className="nav navbar-nav">
            {if @state.user.id
              @link(name: "Profile", path: "user/edit")
            else if setting "allow_signup"
              @link(name: "Login", path: "session")
            }
            {for page in @state.pages when page.active
              if page.children[0]
                <li key={page.name} className="dropdown">
                  <a href="#" className="dropdown-toggle" data-toggle="dropdown">
                    {page.name} <i className="fa fa-caret-down" />
                  </a>
                  <ul className="dropdown-menu">
                    {@link(page)}
                    {@link(child) for child in page.children}
                  </ul>
                </li>
              else
                @link(page)
            }
            {if @state.user.id
              <li>
                <a href="#" onClick={@logout}>Logout</a>
              </li>
            }
          </ul>
        </div>
      </div>
    </div>
