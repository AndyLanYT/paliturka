require 'rails_helper'

RSpec.describe 'Relationships', type: :request do
  let!(:user) { create(:confirmed_user) }
  let!(:followed) { create(:user) }
  let(:auth_headers) { get_headers(user.email, user.password) }

  describe 'POST #create' do
    it 'follows a user' do
      post "/api/v1/users/#{followed.id}/relationships", params: { followed_id: followed.id }, headers: auth_headers,
                                                         as: :json
      expect(response.code).to eq('200')
    end
  end

  describe 'DELETE #destroy' do
    before do
      user.follow(followed)
    end

    it 'unfollows a user' do
      delete "/api/v1/users/#{followed.id}/relationships", headers: auth_headers, as: :json
      expect(response.code).to eq('200')
    end
  end
end
