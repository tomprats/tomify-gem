Component.create "Public.FeedbackButton",
  followStores: ["page"]
  render: ->
    return <div /> unless @state.page.feedback

    <a href="#{path 'feedback'}?page=#{encodeURIComponent(location.href)}" className="feedback-button" title="Feedback">
      <i className="fa fa-meh-o fa-2x" />
    </a>

@addPlugin "Public.FeedbackButton"
