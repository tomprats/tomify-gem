Component.create "Layout.Plugins",
  followStores: ["plugins"]
  render: ->
    <div>
      {for plugin, i in @state.plugins
        Plugin = Component.find plugin

        <Plugin key={i} />
      }
    </div>
