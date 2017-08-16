Store.create "Messages", []
Store.create "Page", {}
Store.create "Pages", []
Store.create "Params", {}
Store.create "Plugins", []
Store.create "Settings", []
Store.create "User", {}

env = Store.create "Env", {}
env.on "change", ->
  current = Store.find("Env").get()
  Store.find("Messages").set current.messages
  Store.find("Page").set current.page
  Store.find("Pages").set current.pages
  Store.find("Settings").set current.settings
  Store.find("User").set current.user ? {}

$ ->
  params = {}
  query = window.location.search[1..]
  for param in query.split("&")
    continue unless "=" in param
    [key, value] = param.split("=")
    params[decodeURIComponent(key)] = decodeURIComponent(value)
  Store.find("Params").set params
  Store.find("Env").set window.env

@message = (message) =>
  message.id ?= @uuid()
  Store.find("Messages").push message
@redirect = (path) -> location.assign path || "/"
@setting = (name) ->
  setting = Store.find("Settings").get().find (setting) -> setting.name == name
  setting?.value
@path = (template, path) ->
  page = Store.find("Pages").get().find (page) -> page.template == template
  page ?= { path: path ? template }
  if page.root then "/" else "/#{page.path}"
@addPlugin = (plugin) -> Store.find("Plugins").push plugin
@uuid = -> Math.random().toString(36).substr(2, 9)
