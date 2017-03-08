class Tomify::Setting < Tomify.models.base
  validates_presence_of :type, :name
  validates_uniqueness_of :name
  validates_format_of :name, with: /\A[a-z_]+\z/, message: "can only contain lowercase letters and underscores"
  validate :type_valid?, on: :update
  validate :name_valid?, on: :update

  after_commit :update_config
  before_destroy { |record| !record.name.in? self.class.required_settings }

  def self.required_settings
    ["allow_signup", "name", "email", "timezone"]
  end

  def self.admin_params
    [:type, :name, :value, :json]
  end

  def serializable_hash(options = nil)
    options ||= {}
    super({ methods: [:type] }.update(options))
  end

  private
  def type_valid?
    errors.add(:type, "cannot change") if type_changed?
  end

  def name_valid?
    return true unless name_was.in? self.class.required_settings
    errors.add(:name, "cannot change if required") if name_changed?
  end

  def update_config
    case name
    when "aws"
      Tomify::CarrierwaveHelper.load_config
    when "email"
      Tomify::EmailHelper.load_config
    when "timezone"
      Tomify::TimezoneHelper.load_config
    end
  end
end
