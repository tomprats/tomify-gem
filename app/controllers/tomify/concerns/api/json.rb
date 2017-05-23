module Tomify::Concerns::Api::JSON
  extend ActiveSupport::Concern

  include Tomify::Concerns::Api::Helpers

  included do
    rescue_from "ActiveRecord::RecordInvalid" do |e|
      render json: {
        type: :warning,
        data: e.record,
        message: e.record.errors.full_messages.join(", ")
      }
    end

    rescue_from "ActiveRecord::RecordNotDestroyed" do |e|
      render json: { type: :warning, message: "#{model_name} could not be deleted" }
    end
  end

  def index
    find_records
    render json: { type: :success, data: data }
  end

  def show
    find_record
    render json: { type: :success, data: data }
  end

  def create
    create_record
    render json: { type: :success, data: data, message: "#{model_name} Created" }
  end

  def update
    find_record
    update_record
    render json: { type: :success, data: data, message: "#{model_name} Updated" }
  end

  def destroy
    find_record
    destroy_record
    render json: { type: :danger, message: "#{model_name} Deleted" }
  end

  private
  def data
    @data ||= (record || records).as_json(serializable_options)
  end
end
