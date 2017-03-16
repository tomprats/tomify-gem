# Tomify

## Controllers
You can override a controller in an initializer

```ruby
Tomify.controllers.base = "ApplicationController"
```

## Views
You can override a default template in a layout file

```haml
- content_for :navbar_partial, "layouts/navbar"
= render "tomify/layouts/application"
```

## License
The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).
