@BuildObject = (key, value) ->
  object = {}
  object[key] = value
  object

@EncodeObject = (object) ->
  last = Object.keys(object).last
  path = ""
  for key, value of object
    path += "#{encodeURIComponent(key)}=#{encodeURIComponent(value)}"
    path += "&" unless key == last
  path

@ObjectEmpty = (object) -> Object.keys(object).length == 0
