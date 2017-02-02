class Tomify::Setting::Json < Tomify::Setting
  validates_presence_of :json

  def value
    json
  end
end
