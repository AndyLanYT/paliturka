require 'rails_helper'

RSpec.describe CommentsController, type: :controller do
  
  let(:user) do
    User.create!(
      email: 'email@example.com',
      password: 'password',
      password_confirmation: 'password'
    )
  end
  
  let(:valid_comment_params) do
    {
      body: 'Just a body'
    }
  end
  # describe 'POST #login' do
  #   it 'response is successful' do
  #     @request.headers['HTTP_JWT_AUD'] = 'test'
  #     post :create, params: { user: { email: user.email, password: user.password } }
  #     byebug
  #     expect(response).to be_successful
  #   end
  # end
end
