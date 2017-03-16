messages = Store.create "Messages", []
settings = Store.create "Settings", []
user = Store.create "User", {}
env = Store.create "Env", {}
env.on "change", ->
  current = env.get()
  messages.set current.messages
  settings.set current.settings
  user.set current.user ? {}

$ -> env.set(window.env)

@message = (message) -> messages.push message
@setting = (name) ->
  setting = settings.get().find (setting) -> setting.name == name
  setting?.value
