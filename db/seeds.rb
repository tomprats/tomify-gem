Tomify::User.create(
  admin: true,
  email: "tprats108@gmail.com",
  first_name: "Tom",
  last_name: "Prats",
  password: "password"
) if Tomify::User.count.zero?

if Tomify::Setting.count.zero?
  Tomify::Setting::Text.create(name: "name", value: "Tomify")
  Tomify::Setting::Boolean.create(name: "allow_signup", value: false)
end

Tomify::Page.create(
  root: true,
  active: true,
  rank: 10,
  path: "home",
  name: "Home",
  template: Tomify::Page.templates.first
) if Tomify::Page.count.zero?
