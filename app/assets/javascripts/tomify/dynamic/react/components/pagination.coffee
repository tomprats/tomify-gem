Component.create "Pagination",
  setPage: (page, e) ->
    e.preventDefault()
    @props.setPage(page)
    false
  render: ->
    first = 1
    prev = @props.page - 1
    next = @props.page + 1
    last = Math.ceil(@props.total / 10)
    prevDisabled = first > prev
    nextDisabled = next > last
    <ul className="pagination">
      <li className="pagination-first#{' disabled' if prevDisabled}">
        <a href="#" onClick={@setPage.bind(null, first)} className="fa fa-angle-double-left" />
      </li>
      <li className="pagination-prev#{' disabled' if prevDisabled}">
        <a href="#" onClick={@setPage.bind(null, prev)} className="fa fa-angle-left" />
      </li>
      <li className="pagination-link active">
        <a href="#" onClick={@setPage.bind(null, @props.page)}>{@props.page}</a>
      </li>
      <li className="pagination-next#{' disabled' if nextDisabled}">
        <a href="#" onClick={@setPage.bind(null, next)} className="fa fa-angle-right" />
      </li>
      <li className="pagination-last#{' disabled' if nextDisabled}">
        <a href="#" onClick={@setPage.bind(null, @props.total)} className="fa fa-angle-double-right" />
      </li>
    </ul>
