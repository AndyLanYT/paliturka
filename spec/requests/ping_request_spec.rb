require 'rails_helper'

RSpec.describe 'Pings', type: :request do
  it 'Returns a status of 200' do
    get '/ping/'
    expect(response).to have_http_status(:ok)
  end

  it 'Returns a status of 401 if not logged in' do
    get '/ping/auth/'
    expect(response).to have_http_status(:unauthorized)
  end

  it 'Returns a status of 200 if logged in' do
    user = create(:confirmed_user)
    auth_headers = get_headers(user.email, user.password)
    get '/ping/auth/', headers: auth_headers
    expect(response).to have_http_status(:ok)
  end
end
