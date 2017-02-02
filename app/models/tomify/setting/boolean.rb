class Tomify::Setting::Boolean < Tomify::Setting
  validates_inclusion_of :value, in: [true, false]

  def value
    super == "true"
  end

  def value=(v)
    super(v.to_s)
  end
end
