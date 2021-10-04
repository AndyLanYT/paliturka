require 'rails_helper'

RSpec.describe 'Likes', type: :request do
  let(:user) { create(:confirmed_user) }
  let(:current_post) { create(:post, user: user) }
  let(:auth_headers) { get_headers(user.email, user.password) }

  describe 'POST /api/v1/posts/:post_id/likes' do
    context 'when we send correct params' do      
      let(:another_post) { create(:post) }

      it 'can\'t be liked by owner of the post' do
        post "/api/v1/posts/#{current_post.id}/likes", headers: auth_headers
        expect(response).to have_http_status(:unauthorized)
      end

      it 'can be liked by another user' do
        post "/api/v1/posts/#{another_post.id}/likes", headers: auth_headers
        parsed = JSON.parse(response.body, object_class: OpenStruct)
        expect(response).to have_http_status(:ok)
        expect(parsed.status).to eq('Successfuly liked!')
      end

      it 'denies creating 2 likes from one person to one post' do
        post "/api/v1/posts/#{another_post.id}/likes", headers: auth_headers
        post "/api/v1/posts/#{another_post.id}/likes", headers: auth_headers
        parsed = JSON.parse(response.body, object_class: OpenStruct)
        expect(response).to have_http_status(:ok)
      end
    end
  end

  describe 'DELETE /api/v2/posts/:post_id/likes/:id' do
    let!(:like) { create(:like, user: user, post: current_post) }

    context 'when data is correct' do
      it 'deletes like' do
        expect do
          delete "/api/v1/posts/#{current_post.id}/likes/#{like.id}", headers: auth_headers
        end.to change(Like, :count).by(-1)
      end
    end
  end
end
