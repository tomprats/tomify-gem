String::assign = (options) ->
  @replace /::.*::/, (replace) -> options[replace.slice(2, -2)] ? ""

String::break = ->
  @replace(/(?!^)([A-Z])/g, "_$1").lowercase.split(/[\W_-]/)

String::date = ->
  new Date(@).toLocaleDateString()

String::startsWith ?= (s) -> @slice(0, s.length) == s
String::endsWith   ?= (s) -> s != "" && @slice(-s.length) == s

String::transform = (method) ->
  string = @replace(/(?!^)([A-Z])/g, "_$1").lowercase
  string = string.splitAndJoin "-", method
  string = string.splitAndJoin "_", method
  string = string.splitAndJoin ".", method
  string

String::splitAnd = (separator, method) ->
  method word for word in @split(separator)

String::splitAndJoin = (separator, method) ->
  @splitAnd(separator, method).join(separator)

Object.defineProperties String.prototype,  {
  camelize: { get: ->
    word = (word.capitalize for word in @break()).join()
    word.charAt(0).lowercase + word.slice(1)
  },
  capitalize: { get: ->
    @transform (word) -> word.charAt(0).toUpperCase() + word.slice(1)
  },
  dasherize: { get: -> @break().join("-") },
  lowercase: { get: -> @toLowerCase() },
  pluralize: { get: -> "#{@}s" },
  titleize: { get: -> (word.capitalize for word in @break() when word isnt "id").join(" ") },
  underscore: { get: -> @break().join("_") },
  uppercase: { get: -> @toUpperCase() }
}
