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

  # describe 'post #create' do
  #   it 'response is successful' do
  #     post :create, params: { user: valid_user_params }
  #     byebug
  #     expect(response).to be_successful
    # end
  # end
end
