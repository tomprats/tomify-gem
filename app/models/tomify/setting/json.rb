class Tomify::Setting::Json < Tomify::Setting
  validates_presence_of :json

  def value
    json
  end

  def value=(value)
    self.json = value
  end
end
