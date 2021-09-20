require 'rails_helper'

RSpec.describe Post, type: :model do
  let(:user) { create(:user) }

  it 'can not have a body' do
    post = described_class.new(body: nil, user: user)
    expect(post).to be_valid
  end

  it 'has body length maximum 100 characters' do
    post = described_class.new(body: 'Just a body', user: user)
    expect(post).to be_valid

    post.body = '*' * 100
    expect(post).to be_valid

    post.body = '*' * 101
    expect(post).not_to be_valid
  end

  it 'must belong to a user' do
    post = described_class.new(body: nil, user: nil)
    expect(post).not_to be_valid

    post.user = user
    expect(post).to be_valid
  end
end
