class ApplicationController < ActionController::API
  include Pundit

  rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized

  before_action :configure_permitted_parameters, if: :devise_controller?

  protected

  def current_token
    request.env['warden-jwt_auth.token']
  end

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: %i[email avatar])
    devise_parameter_sanitizer.permit(:sign_in, keys: [:email])
  end

  def authorize_manually(namespace, record, query = nil)
    policy = Pundit::PolicyFinder.new(namespace).policy!
    query ||= params[:action].to_s + '?'
    return false unless record
    return true if policy.new(current_user, record).send query
    raise NotAuthorizedError, query: query, record: record, policy: policy
  end

  private

  def user_not_authorized
    render json: { message: I18n.t('api.unauthorized') }, status: :unauthorized
    nil
  end
end
