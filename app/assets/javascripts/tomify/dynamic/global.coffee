$ ->
  @message = (message) -> Store.find("Messages").push message
  @setting = (name) ->
    setting = env.settings.find (setting) -> setting.name == name
    setting?.value
  @user = Store.create "User", window.env.user
