require 'rails_helper'

RSpec.describe SessionsController, type: :controller do
  let(:valid_user_params) do
    {
      email: 'test@example.com',
      password: 'password',
      password_confirmation: 'password'
    }
  end

  let(:user) do
    User.create!(
      email: 'email@example.com',
      password: 'password',
      password_confirmation: 'password'
    )
  end

  before do
    @request.env['devise.mapping'] = Devise.mappings[:user]
  end

  describe 'POST #login' do
    it 'response is successful' do
      @request.headers['HTTP_JWT_AUD'] = 'test'
      post :create, params: { user: { email: user.email, password: user.password } }
      byebug
      expect(response).to be_successful
    end
  end
end
