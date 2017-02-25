class @Component extends Namespace
  @base: window
  @create: (namespace, component) ->
    component.displayName ?= namespace
    component.mixins = @defaultMixins.concat(component.mixins || [])
    @namespace namespace, React.createClass(component)
  @defaultMixins: [WillInitializeMixin, FollowMixin]
