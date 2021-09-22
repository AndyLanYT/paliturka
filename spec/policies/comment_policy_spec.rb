require 'rails_helper'

RSpec.describe CommentPolicy, type: :policy do
  subject { described_class }

  let(:visitor) { nil }
  let(:user) { create(:user) }
  let(:admin) { create(:user, admin: true) }

  permissions :index? do
    context 'when user is authenticated' do
      it 'grants access if user is an admin' do
        expect(subject).to permit(admin)
      end

      it 'grants access if user is present' do
        expect(subject).to permit(user)
      end
    end

    context 'when user is not authenticated' do
      it { expect(subject).not_to permit(visitor) }
    end
  end

  permissions :show? do
    context 'when user is authenticated' do
      it 'grants access if user is an admin' do
        expect(subject).to permit(admin)
      end

      it 'grants access if user is present' do
        expect(subject).to permit(user)
      end
    end

    context 'when user is not authenticated' do
      it { expect(subject).not_to permit(visitor) }
    end
  end

  permissions :create? do
    context 'when user is authenticated' do
      it 'grants access if user is an admin' do
        expect(subject).to permit(admin)
      end

      it 'grants access if user is present' do
        expect(subject).to permit(user)
      end
    end

    context 'when user is not authenticated' do
      it { expect(subject).not_to permit(visitor) }
    end
  end

  permissions :update? do
    context 'when user is authenticated' do
      let(:commentator) { create(:user) }
      let(:post) { create(:post, user: user) }
      let(:comment) { create(:comment, user: commentator, post: post) }

      it 'grants access if user\'s comment' do
        expect(subject).to permit(commentator, comment)
      end

      it 'denies if not user\'s comment' do
        expect(subject).not_to permit(admin, comment)
      end
    end

    context 'when user is not authenticated' do
      it { expect(subject).not_to permit(visitor) }
    end
  end

  permissions :destroy? do
    let(:another_user) { create(:user) }

    context 'when user is authenticated' do
      let(:commentator) { create(:user) }
      let(:post) { create(:post, user: user) }
      let(:comment) { create(:comment, user: commentator, post: post) }

      it 'grants access if user is an admin' do
        expect(subject).to permit(admin, comment)
      end

      it 'grants access if user\'s comment' do
        expect(subject).to permit(commentator, comment)
      end

      it 'grants access if user\'s post' do
        expect(subject).to permit(user, post)
      end

      it 'denies if not user\'s comment' do
        expect(subject).not_to permit(another_user, comment)
      end
    end

    context 'when user is not authenticated' do
      it { expect(subject).not_to permit(visitor) }
    end
  end
end
