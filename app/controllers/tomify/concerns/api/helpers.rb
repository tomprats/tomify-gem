module Tomify::Concerns::Api::Helpers
  def find_records
    @records ||= model.where(search_params)
  end

  def find_record
    @record ||= model.find(params[:id])
  end

  def create_record
    @record ||= model.create!(record_params)
  end

  def update_record
    @record.update!(record_params)
  end

  def destroy_record
    @record.destroy!
  end

  def record_params
    params.require(model_param).permit(model.default_params)
  end

  def search_params
    @search_params = {}
    @search_params[:created_at] = date_range(params[:created_at]) if params[:created_at]
    @search_params[:updated_at] = date_range(params[:updated_at]) if params[:updated_at]
    @search_params
  end

  def model
    return @model if @model
    @model = model_name.constantize rescue nil
    @model ||= "Tomify::#{model_name}".constantize
  end

  def model_name
    @model_name ||= controller_name.chomp("s").titleize
  end

  def model_param
    @model_param ||= controller_name.chomp("s")
  end

  def date_range(start_date, end_date = nil)
    start_date = DateTime.strptime(start_date, "%D")
    end_date = end_date ? DateTime.strptime(end_date, "%D") : DateTime.now

    (start_date.beginning_of_day)..(end_date.end_of_day)
  end
end
