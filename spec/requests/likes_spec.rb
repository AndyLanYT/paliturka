# require 'rails_helper'

RSpec.describe 'Likes', type: :request do
  let(:user) { create(:confirmed_user) }
  let(:current_post) { create(:post, user: user) }
  let(:auth_headers) { get_headers(user.email, user.password) }

  describe 'POST /api/v1/posts/:post_id/likes' do
    context 'when we send correct params' do
      before do
        post "/api/v1/posts/#{current_post.id}/likes", headers: auth_headers
      end

      it 'shows like' do
        parsed = JSON.parse(response.body, object_class: OpenStruct)
        expect(response).to have_http_status(:ok)
        expect(parsed.status).to eq('Successfuly liked!')
      end

      it 'denies creating 2 like from one person to one post' do
        post "/api/v1/posts/#{current_post.id}/likes", headers: auth_headers
        parsed = JSON.parse(response.body, object_class: OpenStruct)
        expect(response).to have_http_status(:ok)
        expect(parsed.error).to eq('Can\'t be liked twice!')
      end
    end

    context 'when we send incorrect post id' do
      it 'can\'t find a post' do
        post '/api/v1/posts/-1/likes', headers: auth_headers
        expect(response).to have_http_status(:not_found)
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

    context 'when data is incorrect' do
      it 'can\'t find a post' do
        delete '/api/v1/posts/-1/likes/-1', headers: auth_headers
        expect(response).to have_http_status(:not_found)
      end
    end

    context 'when post_id is incorrect and like_id is correct ' do
      it 'can\'t find a post' do
        delete "/api/v1/posts/-1/likes/#{like.id}", headers: auth_headers
        expect(response).to have_http_status(:not_found)
      end
    end

    context 'when post_id is correct and like_id is incorrect' do
      it do
        delete "/api/v1/posts/#{current_post.id}/likes/-1", headers: auth_headers
        expect(response).to have_http_status(:not_found)
      end
    end
  end
end
