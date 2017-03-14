Component.create "Layout.Analytics",
  componentDidMount: ->
    @google()
    @itunes()
  google: ->
    return unless code = setting "google_analytics_code"

    window.GoogleAnalyticsObject = "ga"
    window.ga = (args...) -> window[window.GoogleAnalyticsObject] args...
    window?[window.GoogleAnalyticsObject] ?= (args...) ->
      api = window[window.GoogleAnalyticsObject]
      (api.q or= []).push args
      return
    window.ga.l = new Date().getTime()
    script = document.createElement "script"
    script.type = "text/javascript"
    script.src = "//www.google-analytics.com/analytics.js"
    script.async = true
    tag = document.getElementsByTagName("script")[0]
    tag.parentNode.insertBefore script, tag

    ga "create", code, "auto"
    ga "send", "pageview"
  itunes: ->
    window._merchantSettings ?= []
    window._merchantSettings.push ["AT", "1001lbag"]
    script = document.createElement "script"
    script.type = "text/javascript"
    script.src = "//autolinkmaker.itunes.apple.com/js/itunes_autolinkmaker.js"
    script.async = true
    tag = document.getElementsByTagName("script")[0]
    tag.parentNode.insertBefore script, tag
  render: ->
    <script />
