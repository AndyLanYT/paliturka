CarrierWave.configure do |config|
  config.fog_credentials = {
    provider: 'AWS',
    aws_access_key_id: ENV['AWS_ACCESS_KEY_ID'],
    aws_secret_access_key: ENV['AWS_SECRET_ACCESS_KEY'],
    region: ENV['REGION']
  }

  if Rails.env.development?
    config.storage = :file
  end

  if Rails.env.production?
    config.storage = :fog
    config.fog_directory = ENV['AWS_BUCKET']
  end

  config.fog_public = false
  config.fog_attributes = { cache_control: "public, max-age=#{365.days.to_i}" }
end
