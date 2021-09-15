require 'rails_helper'

RSpec.describe Comment, type: :model do
  let(:user) { create_user }
  let(:current_post) { create_post(user: user) }

  it 'has a body length maximum 100 charecters' do
    comment = described_class.new(body: nil, user: user, post: current_post)
    expect(comment).to be_valid

    comment.body = '*' * 100
    expect(comment).to be_valid

    comment.body = '*' * 101
    expect(comment).not_to be_valid
  end

  it 'must belong to a user' do
    comment = described_class.new(body: nil, user: nil, post: current_post)
    expect(comment).not_to be_valid

    comment.user = user
    expect(comment).to be_valid
  end

  it 'must belong to a post' do
    comment = described_class.new(body: nil, user: user, post: nil)
    expect(comment).not_to be_valid

    comment.post = current_post
    expect(comment).to be_valid
  end
end
