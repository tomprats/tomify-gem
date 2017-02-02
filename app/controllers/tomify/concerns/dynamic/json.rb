module Tomify::Concerns::Dynamic::JSON
  extend ActiveSupport::Concern

  include Tomify::Concerns::Dynamic

  included do
    rescue_from "ActiveRecord::RecordInvalid" do |e|
      render json: {
        type: :warning,
        data: e.record,
        message: e.record.errors.full_messages.join(", ")
      }
    end

    rescue_from "ActiveRecord::RecordNotDestroyed" do |e|
      render json: { type: :warning, message: "#{model.name} could not be deleted" }
    end
  end

  def index
    find_records
    render json: { type: :success, data: @records }
  end

  def show
    find_record
    render json: { type: :success, data: @record }
  end

  def create
    create_record
    render json: { type: :success, data: @record, message: "#{model.name} Created" }
  end

  def update
    find_record
    update_record
    render json: { type: :success, data: @record, message: "#{model.name} Updated" }
  end

  def destroy
    find_record
    destroy_record
    render json: { type: :danger, message: "#{model.name} Deleted" }
  end
end
