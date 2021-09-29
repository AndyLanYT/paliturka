require 'rails_helper'

RSpec.describe Profile, type: :model do
  let(:user) { create(:user) }

  it 'has first_name length maximum 25 characters' do
    profile = described_class.new(first_name: nil, last_name: 'Lanoff', info: 'I\'m a Ruby developer', user: user)
    expect(profile).to be_valid

    profile.first_name = '*' * 25
    expect(profile).to be_valid

    profile.first_name = '*' * 26
    expect(profile).not_to be_valid
  end

  it 'has last_name length maximum 30 characters' do
    profile = described_class.new(first_name: 'Andy', last_name: nil, info: 'I\'m a Ruby developer', user: user)
    expect(profile).to be_valid

    profile.last_name = '*' * 30
    expect(profile).to be_valid

    profile.last_name = '*' * 31
    expect(profile).not_to be_valid
  end

  it 'has info length maximum 150 characters' do
    profile = described_class.new(first_name: 'Andy', last_name: 'Lanoff', info: nil, user: user)
    expect(profile).to be_valid

    profile.info = '*' * 150
    expect(profile).to be_valid

    profile.info = '*' * 151
    expect(profile).not_to be_valid
  end

  it 'must belong to a user' do
    profile = described_class.new(first_name: nil, last_name: nil, info: nil, user: nil)
    expect(profile).not_to be_valid

    profile.user = user
    expect(profile).to be_valid
  end
end
