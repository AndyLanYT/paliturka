require 'rails_helper'

RSpec.describe User, type: :model do
  it 'has a valid email' do
    user = described_class.new(email: 'not valid', password: 'password')
    expect(user).not_to be_valid

    user.email = 'test@example.com'
    expect(user).to be_valid
  end

  it 'has a password' do
    user = described_class.new(email: 'test@example.com')
    expect(user).not_to be_valid

    user.password = 'password'
    expect(user).to be_valid
  end

  it 'has a password length between 6 and 128' do
    user = described_class.new(email: 'test@example.com', password: nil)
    expect(user).not_to be_valid

    user.password = '*' * 6
    expect(user).to be_valid

    user.password = '*' * 128
    expect(user).to be_valid

    user.password = '*' * 129
    expect(user).not_to be_valid
  end

  it 'has a valid avatar' do
    user = described_class.new(email: 'test@example.com', password: 'password')
    File.open(Rails.root.join('spec/fixtures/files/standard_avatar.png')) { |f| user.avatar = f }
    user.save
    expect(user.avatar.file.nil?).to be false
  end

  it 'has not an avatar' do
    user = described_class.new(email: 'test@example.com', password: 'password')
    user.save!
    expect(user.avatar.file.nil?).to be true
  end
end
