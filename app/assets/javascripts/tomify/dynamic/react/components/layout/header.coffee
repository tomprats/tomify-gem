Component.create "Layout.Header",
  render: ->
    image = setting "header_image"
    text = setting "header_text"
    return <div /> unless image && text

    <div className="navbar navbar-default center header">
      <div className="container-fluid">
        <div className="row">
          <div className="col-lg-8 col-lg-offset-2">
            <div className="row">
              <div className="col-sm-3">
                <div className="navbar-header">
                  <a href="/" class="navbar-brand">
                    <img src={image.url} alt="Logo" />
                  </a>
                </div>
              </div>
              <div className="col-sm-9">
                <div className="navbar-text">
                  <h3>{text}</h3>
                </div>
              </div>
            </div>
          </div>
        </div>
      </div>
    </div>
