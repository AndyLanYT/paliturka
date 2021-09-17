class ApplicationController < ActionController::API
  include Pundit

  rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized

  before_action :configure_permitted_parameters, if: :devise_controller?

  protected

  def current_token
    request.env['warden-jwt_auth.token']
  end

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:email])
    devise_parameter_sanitizer.permit(:sign_in, keys: [:email])
  end

  private

  def user_not_authorized
    render json: { message: I18n.t('api.unauthorized') }, status: :unauthorized
    nil
  end
end
