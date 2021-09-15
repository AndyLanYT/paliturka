# require 'rails_helper'

RSpec.describe 'Comment CRUD', type: :request do
  let!(:user) { create_user(id: 1, email: 'test@example.com', password: 'password', password_confitmation: 'password') }
  let!(:current_post) { create_post(user: user) }
  let(:auth_headers) { get_headers(user.email, user.password) }

  describe 'GET #index' do
    before do
      Comment.create(body: 'Comment body', user: user, post: current_post)
    end

    it 'response is successful' do
      get "/api/v1/posts/#{current_post.id}/comments", headers: auth_headers, as: :json
      expect(Comment.count).to eq 1
    end
  end

  describe 'GET #show' do
    let(:comment) { create_comment(user: user, post: current_post) }

    it 'response is successful' do
      get "/api/v1/posts/#{comment.post_id}/comments/#{comment.id}"
      expect(Comment.find(comment.id).body).to eq comment.body
    end
  end

  describe 'POST #create' do
    let(:valid_comment_params) do
      {
        body: 'Comment body'
      }
    end

    it 'response is successful' do
      post "/api/v1/posts/#{current_post.id}/comments", params: { comment: valid_comment_params },
                                                        headers: auth_headers, as: :json
      expect(Comment.count).to eq 1
    end
  end

  describe 'PUT #update' do
    let(:comment) { create_comment(user: user) }
    let(:valid_comment_params) do
      {
        body: 'New body'
      }
    end

    it 'response is successful' do
      put "/api/v1/posts/#{comment.post_id}/comments/#{comment.id}", params: { comment: valid_comment_params },
                                                                     headers: auth_headers, as: :json
      expect(Comment.find(comment.id).body).to eq valid_comment_params[:body]
    end
  end

  describe 'DELETE #destroy' do
    let(:comment) { create_comment(user: user, post: current_post) }

    it 'response is successfull' do
      delete "/api/v1/posts/#{comment.post_id}/comments/#{comment.id}", headers: auth_headers, as: :json
      expect(Comment.count).to eq 0
    end
  end

  # UPDATE
  context 'when PUT /api/v1/posts/:post_id/comments/:id' do
    context 'without a user' do
      it 'returns a 404' do
        record = create_comment
        put "/api/v1/posts/#{record.post_id}/comments/#{record.id}", params: '{ "comment": { "body": "New body" } }'
        expect(response).to have_http_status(:not_found)
      end
    end

    context 'with a non-user of comment' do
      it 'does not let me update a comment' do
        user1 = create_user
        user2 = create_user
        record = create_comment({ user: user1 })
        put "/api/v1/posts/#{record.post_id}/comments/#{record.id}", params: '{ "comment": { "body": "New body" } }',
                                                                     headers: get_headers(user2.email, user2.password)
        expect(response).to have_http_status(:not_found)
      end
    end

    context 'with an org owner' do
      it 'lets me update a comment' do
        record = create_comment({ user: user })
        put "/api/v1/posts/#{record.post_id}/comments/#{record.id}", params: '{ "comment": { "body": "New body" } }',
                                                                     headers: auth_headers
        parsed = JSON.parse(response.body, object_class: OpenStruct)
        expect(response).to have_http_status(:ok)
        expect(parsed.body).to eq('New body')
      end
    end
  end

  # DESTROY
  context 'when DELETE /api/v1/posts/:post_id/comments/:id' do
    context 'without a user' do
      it 'returns a 404' do
        record = create_comment
        delete "/api/v1/posts/#{record.post_id}/comments/#{record.id}"
        expect(response).to have_http_status(:not_found)
      end
    end

    context 'with a user' do
      it 'does not let me destroy a comment' do
        user1 = create_user
        user2 = create_user
        record = create_comment({ user: user1 })
        delete "/api/v1/posts/#{record.post_id}/comments/#{record.id}",
               headers: get_headers(user2.email, user2.password)
        expect(response).to have_http_status(:not_found)
      end
    end

    context 'with a user (owner)' do
      it 'lets me destroy a comment' do
        record = create_comment({ user: user })
        delete "/api/v1/posts/#{record.post_id}/comments/#{record.id}", headers: auth_headers
        expect(response).to have_http_status(:ok)
      end
    end
  end
end
