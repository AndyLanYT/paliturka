require 'rails_helper'

RSpec.describe Like, type: :model do
  let(:user) { create(:user) }
  let(:post) { create(:post) }

  it 'must belong to a user' do
    like = described_class.new(user: nil, post: post)
    expect(like).not_to be_valid

    like.user = user
    expect(like).to be_valid
  end

  it 'must belong to a post' do
    like = described_class.new(user: user, post: nil)
    expect(like).not_to be_valid

    like.post = post
    expect(like).to be_valid
  end
end
