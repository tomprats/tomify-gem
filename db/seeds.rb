Tomify.models.user.create(
  admin: true,
  email: "tom@tomify.me",
  first_name: "Tom",
  last_name: "Prats",
  password: "password"
) if Tomify.models.user.count.zero?

if Tomify.models.setting.count.zero?
  Tomify::Setting::Text.create(name: "name", value: "Tomify")
  Tomify::Setting::Text.create(name: "timezone", value: "Eastern Time (US & Canada)")
  Tomify::Setting::Boolean.create(name: "allow_signup", value: false)
  Tomify::Setting::Json.create(name: "aws", value: {
    access_key: "",
    secret_key: "",
    bucket: "",
  })
  Tomify::Setting::Json.create(name: "email", value: {
    username: "",
    password: "",
    base_url: "http://localhost:3000"
  })
end

Tomify.models.page.create(
  root: true,
  active: true,
  rank: 10,
  path: "home",
  name: "Home",
  template: Tomify.models.page.first
) if Tomify.models.page.count.zero?
