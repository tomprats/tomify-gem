String::assign = (options) ->
  @replace /::.*::/, (replace) -> options[replace.slice(2, -2)] ? ""

String::break = ->
  @replace(/(?!^)([A-Z])/g, "_$1").lowercase.split(/[\W_-]/)

String::date = ->
  new Date(@).toLocaleDateString()

Object.defineProperties String.prototype,  {
  camelize: { get: ->
    word = (word.capitalize for word in @break()).join()
    word.charAt(0).lowercase + word.slice(1)
  },
  capitalize : { get: -> @charAt(0).toUpperCase() + @slice(1) },
  dasherize : { get: -> @break().join("-") },
  lowercase : { get: -> @toLowerCase() },
  pluralize: { get: -> "#{@}s" },
  titleize: { get: -> (word.capitalize for word in @break() when word isnt "id").join(" ") },
  underscore: { get: -> @break().join("_") },
  uppercase: { get: -> @toUpperCase() }
}
