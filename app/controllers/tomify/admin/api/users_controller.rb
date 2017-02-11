class Tomify::Admin::Api::UsersController < Tomify.admin_api_controller.constantize
  def destroy
    @record = model.find(params[:id])
    return super unless @record.email == "tom@tomify.me" || @record.id == current_user.id
    render json: { type: :danger, message: "You shall not pass" }
  end
end
