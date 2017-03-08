class Tomify::Api::Public::UsersController < Tomify.controllers.public_api
  before_action :require_user!, only: [:show, :update]
  before_action :set_record, only: [:show, :update]

  private
  def set_record
    @record = current_user
  end
end
