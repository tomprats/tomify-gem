class @Request
  @none: (data) -> data
  @make: (type) ->
    (path, params) -> @ajax(type: type, url: path, data: params)
  @get: @make("GET")
  @post: @make("POST")
  @put: @make("PUT")
  @delete: @make("DELETE")
  @ajax: (options) ->
    options.url = options.url.assign(options.data)
    if options.type in ["POST", "PUT"]
      Object.assign options, {
        data: @formData(new FormData(), options.data),
        cache: false,
        processData: false,
        contentType: false
      }
    $.ajax(options)
  @formData: (data, object, objectName) ->
    for key, value of object
      name = if objectName then "#{objectName}[#{key}]" else key
      if value not instanceof Object || value instanceof File
        data.append(name, value)
      else
        data = @formData(data, value, name)
    data
