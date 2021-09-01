require 'rails_helper'

RSpec.describe 'Registration', type: :request do
  let(:valid_user_params) do
    {
      email: 'test@example.com',
      password: 'password',
      password_confirmation: 'password'
    }
  end

  # describe 'POST #create' do
    # it 'response is successful' do
      # post '/users', params: { user: valid_user_params }
      # expect(response).to be_successful
      # expect(User.count).to eq 1
      # expect(User.first.surname).to eq valid_user_params[:surname]
    # end
  # end
end
