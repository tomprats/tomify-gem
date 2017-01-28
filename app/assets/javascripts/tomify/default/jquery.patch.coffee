for method in ["put", "delete"]
  do (method) ->
    $[method] = (url, data, callback, type) ->
      if $.isFunction(data)
        type = type || callback
        callback = data
        data = undefined

      $.ajax(url: url, type: method, dataType: type, data: data, success: callback)
