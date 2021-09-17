# require 'rails_helper'

RSpec.describe 'Post CRUD', type: :request do
  let!(:user) { create_user(id: 1, email: 'test@example.com', password: 'password', password_confitmation: 'password') }
  let(:auth_headers) { get_headers(user.email, user.password) }

  describe 'GET #index' do
    before do
      Post.create(body: 'Just a body', user: user)
    end

    it 'response is successful' do
      get '/api/v1/posts', headers: auth_headers, as: :json
      expect(Post.count).to eq 1
    end
  end

  describe 'GET #show' do
    let(:current_post) { create_post(user: user) }

    it 'response is successful' do
      get "/api/v1/posts/#{current_post.id}", headers: auth_headers, as: :json
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
      post '/api/v1/posts', params: { post: valid_post_params }, headers: auth_headers, as: :json
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
      put "/api/v1/posts/#{current_post.id}", params: { post: valid_post_params }, headers: auth_headers, as: :json
      expect(Post.find(current_post.id).body).to eq valid_post_params[:body]
    end
  end

  describe 'DELETE #destroy' do
    let(:current_post) { create_post(user: user) }

    it 'response is successfull' do
      delete "/api/v1/posts/#{current_post.id}", headers: auth_headers, as: :json
      expect(Post.count).to eq 0
    end
  end

  # UPDATE
  context 'when PUT /api/v1/posts/:id' do
    context 'without a user' do
      it 'returns a 401' do
        record = create_post
        put "/api/v1/posts/#{record.id}", params: '{ "post": { "body": "New body" } }'
        expect(response).to have_http_status(:unauthorized)
      end
    end

    context 'with a non-user of post' do
      it 'does not let me update a post' do
        user1 = create_user
        user2 = create_user
        record = create_post({ user: user1 })
        put "/api/v1/posts/#{record.id}", params: '{ "post": { "body": "New body" } }',
                                          headers: get_headers(user2.email, user2.password)
        expect(response).to have_http_status(:unauthorized)
      end
    end

    context 'with an org owner' do
      it 'lets me update a post' do
        record = create_post({ user: user })
        put "/api/v1/posts/#{record.id}", params: '{ "post": { "body": "New body" } }', headers: auth_headers
        parsed = JSON.parse(response.body, object_class: OpenStruct)
        expect(response).to have_http_status(:ok)
        expect(parsed.body).to eq('New body')
      end
    end
  end

  # DESTROY
  context 'when DELETE /api/v1/posts/:id' do
    context 'without a user' do
      it 'returns a 401' do
        record = create_post
        delete "/api/v1/posts/#{record.id}"
        expect(response).to have_http_status(:unauthorized)
      end
    end

    context 'with a user' do
      it 'does not let me destroy a post' do
        user1 = create_user
        user2 = create_user
        record = create_post({ user: user1 })
        delete "/api/v1/posts/#{record.id}", headers: get_headers(user2.email, user2.password)
        expect(response).to have_http_status(:unauthorized)
      end
    end

    context 'with a user (owner)' do
      it 'lets me destroy a post' do
        record = create_post({ user: user })
        delete "/api/v1/posts/#{record.id}", headers: auth_headers
        expect(response).to have_http_status(:ok)
      end
    end
  end
end
