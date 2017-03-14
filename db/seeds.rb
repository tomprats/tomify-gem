def debug(record)
  puts record.errors.full_messages unless record.valid?
end

if Tomify.models.user.count.zero?
  puts "Creating Default Users"
  debug Tomify.models.user.create(
    admin: true,
    email: "tom@tomify.me",
    first_name: "Tom",
    last_name: "Prats",
    password: "password"
  )
end

if Tomify.models.setting.count.zero?
  puts "Creating Default Settings"
  debug Tomify::Setting::Text.create(name: "name", value: "Tomify", public: true)
  debug Tomify::Setting::Text.create(name: "timezone", value: "Eastern Time (US & Canada)")
  debug Tomify::Setting::Boolean.create(name: "allow_signup", value: false, public: true)
  debug Tomify::Setting::Json.create(name: "aws", value: {
    access_key: "",
    secret_key: "",
    bucket: "",
  })
  debug Tomify::Setting::Json.create(name: "email", value: {
    username: "",
    password: "",
    base_url: "http://localhost:3000"
  })
end

if Tomify.models.page.count.zero?
  puts "Creating Default Pages"
  debug Tomify.models.page.create(
    root: true,
    active: true,
    rank: 10,
    path: "home",
    name: "Home",
    template: Tomify.models.page.templates.first
  )
end
