class Tomify::Setting < Tomify.base_record.constantize
  validates_presence_of :type, :name
  validates_uniqueness_of :name
end
