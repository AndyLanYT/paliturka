require 'rails_helper'

RSpec.describe RegistrationsController, type: :controller do
  let(:valid_user_params) do
    {
      email: 'test@example.com',
      password: 'password',
      password_confirmation: 'password'
    }
  end

  before do
    @request.env['devise.mapping'] = Devise.mappings[:user]
  end

  describe 'POST #create' do
    it 'response is successful' do
      post :create, params: { user: valid_user_params }
      expect(response).to be_successful
      expect(User.count).to eq 1
      expect(User.first.email).to eq valid_user_params[:email]
    end
  end
end
