# require 'rails_helper'

RSpec.describe 'Post CRUD', type: :request do
  let!(:user) { create_user(id: 1, email: 'test@example.com', password: 'password', password_confitmation: 'password') }
  let(:a) { get_headers(user.email, user.password) }

  describe 'GET #index' do
    before do
      Post.create(body: 'Just a body', user: user)
    end

    it 'response is successful' do
      get '/api/v1/posts', headers: a, as: :json
      expect(Post.count).to eq 1
    end
  end

  describe 'GET #show' do
    let(:current_post) { create_post(user: user) }

    it 'response is successful' do
      get "/api/v1/posts/#{current_post.id}", headers: a, as: :json
      expect(Post.find(current_post.id).body).to eq current_post.body
    end
  end

  describe 'POST #create' do
    let(:valid_post_params) do
      {
        body: 'Just a body',
        user: user
      }
    end

    it 'response is successful' do
      post '/api/v1/posts', params: { post: valid_post_params }, headers: a, as: :json
      expect(Post.count).to eq 1
    end
  end

  describe 'PUT #update' do
    let(:current_post) { create_post(user: user) }
    let(:valid_post_params) do
      {
        body: 'New body'
      }
    end

    it 'response is successful' do
      put "/api/v1/posts/#{current_post.id}", params: { post: valid_post_params }, headers: a, as: :json
      expect(Post.find(current_post.id).body).to eq valid_post_params[:body]
    end
  end

  describe 'DELETE #destroy' do
    let(:current_post) { create_post(user: user) }

    it 'response is successfull' do
      delete "/api/v1/posts/#{current_post.id}", headers: a, as: :json
      expect(Post.count).to eq 0
    end
  end
end
