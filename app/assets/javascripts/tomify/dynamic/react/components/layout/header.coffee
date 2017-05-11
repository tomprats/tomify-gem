Component.create "Layout.Header",
  render: ->
    image = setting "header_image"
    text = setting "header_text"
    return <div /> unless image || text

    image = image && <div className="header-image">
      <a href="/">
        <img src={image.url} alt="Logo" />
      </a>
    </div>

    text = text && <div className="header-text">
      <h3>{text}</h3>
    </div>

    <div className="container-fluid header">
      <div className="row">
        <div className="col-md-8 col-md-offset-2">
          {if image && text
            <div className="row">
              <div className="col-sm-3">{image}</div>
              <div className="col-sm-9">{text}</div>
            </div>
          else
            <div className="header-center">
              {if image then image else text}
            </div>
          }
        </div>
      </div>
    </div>
