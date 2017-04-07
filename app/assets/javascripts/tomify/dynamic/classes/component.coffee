class @Component extends Namespace
  @base: window
  @create: (namespace, component) ->
    component.displayName ?= namespace
    component.mixins = @defaultMixins.concat(component.mixins || [])
    value = @namespace namespace, React.createClass(component)
    @public namespace
    value
  @defaultMixins: [WillInitializeMixin, FollowMixin]
