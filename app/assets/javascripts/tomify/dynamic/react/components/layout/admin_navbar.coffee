Component.create "Layout.AdminNavbar",
  followStores: ["user", pages: "Navbar.Admin"]
  componentWillInitialize: ->
    env = Store.find "Env"
    pages = Store.create "Navbar.Admin", env.get().navbar.admin || []
    @follow env.on "change", -> pages.set env.get().navbar.public
  link: (page) ->
    <li key={page.name}>
      <a href={page.url} target={"_blank" if page.external}>{page.name}</a>
    </li>
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
          </ul>
        </div>
      </div>
    </div>
