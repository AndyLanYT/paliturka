require 'rails_helper'

RSpec.describe 'Users', type: :request do
  let(:user) { create(:confirmed_user) }
  let(:follower) { create(:user) }

  describe 'GET #following' do
    before do
      follower.follow(user)
    end

    it 'response is successful' do
      get "/api/v1/users/#{follower.id}/following"
      expect(User.find(follower.id).following.count).to eq 1
      expect(User.find(user.id).following.count).to eq 0
      expect(response.code).to eq('200')
    end
  end

  describe 'GET #followers' do
    before do
      follower.follow(user)
    end

    it 'response is successful' do
      get "/api/v1/users/#{follower.id}/followers"
      expect(User.find(user.id).followers.count).to eq 1
      expect(User.find(follower.id).followers.count).to eq 0
      expect(response.code).to eq('200')
    end
  end
end
