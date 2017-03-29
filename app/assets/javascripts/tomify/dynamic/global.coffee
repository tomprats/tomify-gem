Store.create "Messages", []
Store.create "Settings", []
Store.create "User", {}
env = Store.create "Env", {}
env.on "change", ->
  current = Store.find("Env").get()
  Store.find("Messages").set current.messages
  Store.find("Settings").set current.settings
  Store.find("User").set current.user ? {}

$ -> Store.find("Env").set(window.env)

@message = (message) -> Store.find("Messages").push message
@setting = (name) ->
  setting = Store.find("Settings").get().find (setting) -> setting.name == name
  setting?.value
