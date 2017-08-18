Component.create "Pagination",
  setPage: (page, e) ->
    e.preventDefault()
    @props.setPage(page) if page
    false
  render: ->
    first = 1
    prev = @props.page - 1
    next = @props.page + 1
    last = Math.ceil(@props.total / @props.length)
    prevDisabled = first > prev
    nextDisabled = next > last
    <ul className="pagination">
      <li className="pagination-first#{prevDisabled && ' disabled'}">
        <a href="#" onClick={@setPage.bind(null, !prevDisabled && first)} className="fa fa-angle-double-left" />
      </li>
      <li className="pagination-prev#{prevDisabled && ' disabled'}">
        <a href="#" onClick={@setPage.bind(null, !prevDisabled && prev)} className="fa fa-angle-left" />
      </li>
      <li className="pagination-link active">
        <a href="#" onClick={@setPage.bind(null, @props.page)}>{@props.page}</a>
      </li>
      <li className="pagination-next#{nextDisabled && ' disabled'}">
        <a href="#" onClick={@setPage.bind(null, !nextDisabled && next)} className="fa fa-angle-right" />
      </li>
      <li className="pagination-last#{nextDisabled && ' disabled'}">
        <a href="#" onClick={@setPage.bind(null, !nextDisabled && last)} className="fa fa-angle-double-right" />
      </li>
    </ul>
