require 'rails_helper'

RSpec.describe LikePolicy, type: :policy do
  subject { described_class }

  let(:user) { create(:user) }
  let(:another_user) { create(:user) }
  let(:post) { create(:post, user: user) }
  
  permissions :create? do
    context 'when user is authenticated' do
      it 'grants access if not user\'s post' do
        expect(subject).to permit(another_user, post)
      end

      it 'denies if user\'s post' do
        expect(subject).not_to permit(user, post)
      end
    end

    context 'when user is not authenticated' do
      let(:visitor) { nil }

      it { expect(subject).not_to permit(visitor) }
    end
  end

  permissions :destroy? do
    context 'when user is authenticated' do
      let(:like) { create(:like, user: another_user, post: post) }

      it 'grants access if user\'s like' do
        expect(subject).to permit(another_user, like)
      end

      it 'denies if not user\'s like' do
        expect(subject).not_to permit(user, like)
      end
    end

    context 'when user is not authenticated' do
      let(:visitor) { nil }

      it { expect(subject).not_to permit(visitor) }
    end
  end
end
