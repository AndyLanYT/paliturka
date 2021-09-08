require 'rails_helper'

RSpec.describe Comment, type: :model do
  let(:current_user) do
    User.create!(
      id: 153,
      email: 'email@example.com',
      password: 'password'
    )
  end
  let(:current_post) do
    Post.create!(
      id: 239,
      body: 'Just a body',
      user: current_user
    )
  end

  it 'has a body length maximum 100 charecters' do
    comment = described_class.new(body: nil, user: current_user, post: current_post)
    expect(comment).to be_valid

    comment.body = '*' * 100
    expect(comment).to be_valid

    comment.body = '*' * 101
    expect(comment).not_to be_valid
  end
end
