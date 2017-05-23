class Tomify::Api::Admin::SettingsController < Tomify.controllers.admin_api
  def permitted_attributes
    [:type, :name, :public, :value, json: {}]
  end

  def serializable_options
    { methods: [:type] }
  end
end
