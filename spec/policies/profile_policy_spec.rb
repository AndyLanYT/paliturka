require 'rails_helper'

RSpec.describe ProfilePolicy, type: :policy do
  subject { described_class }

  let(:user) { create(:user) }
  let(:another_user) { create(:user) }
  # let(:profile) { create(:profile, user: user) }

  permissions :show? do
    context 'when user is authenticated' do
      it 'grants access if user\'s profile' do
        expect(subject).to permit(user, user.profile)
      end

      it 'grants access if not user\'s profile' do
        expect(subject).to permit(another_user, user.profile)
      end
    end

    context 'when user is not authenticated' do
      let(:visitor) { nil }

      it { expect(subject).not_to permit(visitor, user.profile) }
    end
  end

  permissions :update? do
    context 'when user is authenticated' do
      it 'grants access if user\'s profile' do
        expect(subject).to permit(user, user.profile)
      end

      it 'denies if not user\'s profile' do
        expect(subject).not_to permit(another_user, user.profile)
      end
    end

    context 'when user is not authenticated' do
      let(:visitor) { nil }

      it { expect(subject).not_to permit(visitor) }
    end
  end
end
