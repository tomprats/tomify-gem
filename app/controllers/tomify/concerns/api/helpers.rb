module Tomify::Concerns::Api::Helpers
  def find_records
    @records ||= model.where(search_options)
  end

  def find_record
    @record ||= model.find(params[:id])
  end

  def create_record
    @record ||= model.create!(record_params)
  end

  def update_record
    record.update!(record_params)
  end

  def destroy_record
    record.destroy!
  end

  # Helpers
  def date_range(start_date, end_date = nil)
    start_date = DateTime.strptime(start_date, "%D")
    end_date = end_date ? DateTime.strptime(end_date, "%D") : DateTime.now

    (start_date.beginning_of_day)..(end_date.end_of_day)
  end

  def model
    @model ||= model_class.constantize rescue nil
    @model ||= "Tomify::#{model_class}".constantize
  end

  def model_class
    @model_class ||= controller_name.classify
  end

  def model_name
    @model_name ||= model_class.split("::").first.titleize
  end

  def model_param
    @model_param ||= model_name.underscore
  end

  def record
    @record ||= find_record
  end

  def records
    @records ||= find_records
  end

  def record_params
    @record_params ||= params.require(model_param).permit(permitted_attributes)
  end

  def recursive_options(association, base, depth)
    return base if depth.zero?
    options = base.dup
    options[:include] ||= []
    options[:include] << { association => recursive_options(association, base, depth - 1) }
    options
  end

  def search_options
    @search_options = {}
    @search_options[:created_at] = date_range(params[:created_at]) if params[:created_at]
    @search_options[:updated_at] = date_range(params[:updated_at]) if params[:updated_at]
    @search_options
  end

  def serializable_options
    @serializable_options ||= {}
  end
end
