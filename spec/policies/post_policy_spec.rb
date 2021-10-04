require 'rails_helper'

RSpec.describe PostPolicy, type: :policy do
  subject { described_class }

  let(:visitor) { nil }
  let(:user) { create(:user) }
  let(:admin) { create(:user, admin: true) }
  let(:current_post) { create(:post, user: user) }

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
      it 'grants access if user is a visitor' do
        expect(subject).to permit(visitor)
      end
    end
  end

  permissions :show? do
    let(:another_user) { create(:user) }
    let(:hidden_post) { create(:post, user: user, hidden: true) }

    context 'when user is authenticated' do
      it 'grants access if user is an admin' do
        expect(subject).to permit(admin, current_post)
      end

      it 'grants access if user is present' do
        expect(subject).to permit(user, current_post)
      end

      it 'grants access if user is an admin and post is hidden' do
        expect(subject).to permit(admin, hidden_post)
      end

      it 'grants access if user is the owner of hidden_post' do
        expect(subject).to permit(user, hidden_post)
      end

      it 'denies access if post is hidden' do
        expect(subject).not_to permit(another_user, hidden_post)
      end
    end

    context 'when user is not authenticated' do
      it { expect(subject).not_to permit(visitor, current_post) }
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

    context 'when user is a visitor' do
      it { expect(subject).not_to permit(visitor) }
    end
  end

  permissions :update? do
    context 'when user is authenticated' do
      it 'grants access if user\'s post' do
        expect(subject).to permit(user, current_post)
      end

      it 'denies if not user\'s post' do
        expect(subject).not_to permit(admin, current_post)
      end
    end

    context 'when user is a visitor' do
      it { expect(subject).not_to permit(visitor, current_post) }
    end
  end

  permissions :destroy? do
    context 'when user is authenticated' do
      let(:another_user) { create(:user) }

      it 'grants access if user is an admin' do
        expect(subject).to permit(admin, current_post)
      end

      it 'grants access if user\'s post' do
        expect(subject).to permit(user, current_post)
      end

      it 'denies if not user\'s post' do
        expect(subject).not_to permit(another_user, current_post)
      end
    end

    context 'when user is a visitor' do
      it { expect(subject).not_to permit(visitor, current_post) }
    end
  end
end
