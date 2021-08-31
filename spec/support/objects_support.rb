module ObjectsSupport
  def create_user(params = {})
    user = User.new(
      email: 'test@example.com',
      password: 'password',
      password_confirmation: 'password'
    )
    user.skip_confirmation!
    user.save!
    user
  end
end

RSpec.configure do |config|
  config.include ObjectsSupport
end
