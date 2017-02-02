config = Namespace.find_or_create "Tomify.Config", {}
config = $.extend {
  basePath: ""
}, config
