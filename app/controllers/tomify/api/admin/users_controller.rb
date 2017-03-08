class Tomify::Api::Admin::UsersController < Tomify.controllers.admin_api
  def destroy
    @record = model.find(params[:id])
    return super unless @record.email == "tom@tomify.me" || @record.id == current_user.id
    render json: { type: :danger, message: "You shall not pass" }
  end
end
