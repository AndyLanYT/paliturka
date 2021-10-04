require 'rails_helper'

RSpec.describe 'Profiles', type: :request do
  let(:user) { create(:confirmed_user) }
  let(:auth_headers) { get_headers(user.email, user.password) }

  describe 'GET #show' do
    it 'response is successful' do
      get "/api/v1/users/#{user.id}/profile", headers: auth_headers, as: :json
      expect(Profile.find(user.id).info).to eq user.profile.info
    end
  end

  describe 'PUT #update' do
    let(:valid_profile_params) do
      {
        first_name: 'Carl',
        last_name: 'Son',
        info: 'Helicopter',
        hidden: true
      }
    end

    it 'response is successful' do
      put "/api/v1/users/#{user.id}/profile", params: { profile: valid_profile_params }, headers: auth_headers,
                                              as: :json
      expect(Profile.find_by(user_id: user.id).first_name).to eq valid_profile_params[:first_name]
      expect(Profile.find_by(user_id: user.id).last_name).to eq valid_profile_params[:last_name]
      expect(Profile.find_by(user_id: user.id).info).to eq valid_profile_params[:info]
      expect(Profile.find_by(user_id: user.id).hidden).to eq valid_profile_params[:hidden]
    end
  end

  # UPDATE
  context 'when PUT users/:user_id/profile' do
    context 'with a non-user of profile' do
      it 'does not let me update a profile' do
        user1 = create(:user)
        user2 = create(:user)
        record = user1.profile
        put "/api/v1/users/#{record.user.id}/profile",
            params: '{ "profile": { "first_name": "Carl", "last_name": "Son", "info": "Boy", "hidden": "true" } }',
            headers: get_headers(user2.email, user2.password)
        expect(response).to have_http_status(:unauthorized)
      end
    end

    context 'with an org owner' do
      it 'lets me update a profile' do
        record = user.profile
        put "/api/v1/users/#{record.user.id}/profile",
            params: '{ "profile": { "first_name": "Carl", "last_name": "Son", "info": "Boy", "hidden": "true" } }',
            headers: auth_headers
        parsed = JSON.parse(response.body, object_class: OpenStruct)
        expect(response).to have_http_status(:ok)
        expect(parsed.first_name).to eq('Carl')
        expect(parsed.last_name).to eq('Son')
        expect(parsed.info).to eq('Boy')
        expect(parsed.hidden).to eq(true)
      end
    end
  end
end
