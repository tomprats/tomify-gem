module Tomify::Concerns::Default::AuthHelper
  def not_found
    raise ActionController::RoutingError.new("Not Found")
  end

  def current_user
    @current_user ||= Tomify.models.user.find_by(id: session[:current_user_id])
  end

  def require_user!
    not_found unless current_user
  end

  def require_admin!
    redirect_to root_path unless current_user.admin
  end

  def check_token
    return unless params[:token]
    token = { uuid: params[:token], name: params[:from] }
    user = Tomify.models.user.joins(:tokens).find_by(tokens: token)
    return unless user
    user.update(verified: true) if token[:name] == "email"
    session[:current_user_id] = user.id
  end
end
