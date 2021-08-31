module JwtSupport
  def create_allowlisted_jwts(params = {})
    user = params[:user].presence || create_user
    user.allowlisted_jwts.create!(
      jti: params['jti'].presence || 'TEST',
      aud: params['aud'].presence || 'TEST',
      exp: Time.zone.at(params['exp'].presence.to_i || Time.now.to_i)
    )
  end

  def get_headers(login, password)
    jwt = get_jwt(login, password)
    {
      Accept: 'application/json',
      'Content-Type': 'application/json',
      HTTP_JWT_AUD: 'test',
      Authorization: "Bearer #{jwt}"
    }
  end

  def get_jwt(login, password)
    headers = { HTTP_JWT_AUD: 'test' }
    post '/users/sign_in', params: { user: { email: login, password: password } }, headers: headers
    JSON.parse(response.body, object_class: OpenStruct).jwt
  end
end

RSpec.configure do |config|
  config.include JwtSupport
end
