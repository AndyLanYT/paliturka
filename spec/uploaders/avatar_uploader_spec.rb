require 'rails_helper'
require 'carrierwave/test/matchers'

describe AvatarUploader do
  include CarrierWave::Test::Matchers

  let(:user) { create(:confirmed_user) }
  let(:uploader) { described_class.new(user, :avatar) }

  before do
    described_class.enable_processing = true
    File.open(Rails.root.join('spec/fixtures/files/standard_avatar.png')) { |f| uploader.store!(f) }
  end

  after do
    described_class.enable_processing = false
    uploader.remove!
  end

  it 'makes the image size 100 by 100 pixels' do
    expect(uploader.thumb).to have_dimensions(100, 100)
  end

  it 'makes the image to fit within 200 by 200 pixels' do
    expect(uploader).to be_no_larger_than(400, 400)
  end

  it 'has .jpg .jpeg or .png format' do
    expect(uploader).to be_format('png')
  end
end
