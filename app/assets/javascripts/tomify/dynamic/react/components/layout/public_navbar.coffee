Component.create "Layout.PublicNavbar",
  followStores: ["user", pages: "Navbar.Public"]
  componentWillInitialize: ->
    env = Store.find "Env"
    pages = Store.create "Navbar.Public", env.get().navbar.public || []
    @follow env.on "change", -> pages.set env.get().navbar.public
  logout: (e) ->
    e.preventDefault()
    Model.find("Public.Session").destroy().then (response) ->
      return redirect response.redirect if response.type == "success"
      message type: response.type, text: response.message
  link: (page) ->
    <li key={page.name}>
      <a href={page.url} target={"_blank" if page.external}>{page.name}</a>
    </li>
  render: ->
    root = Store.find("Pages").get().find (page) -> page.root
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
            {if setting "allow_signup"
              if @state.user.id
                @link(name: "Profile", url: "/profile")
              else
                @link(name: "Login", url: "/session")
            }
            {for page in @state.pages
              if page.children[0]
                <li key={page.name} className="dropdown">
                  <a href="#" className="dropdown-toggle" data-toggle="dropdown">
                    {page.name} <i className="fa fa-caret-down" />
                  </a>
                  <ul className="dropdown-menu">
                    {@link(page) if page.url}
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
