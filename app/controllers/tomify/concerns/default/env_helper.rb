module Tomify::Concerns::Default::EnvHelper
  def js_env
    {
      messages: flash.collect { |key, value| { type: key, text: value }},
      navbar: navbar,
      pages: Tomify.models.page.for_env,
      settings: Tomify.models.setting.for_env,
      user: current_user
    }
  end
end
