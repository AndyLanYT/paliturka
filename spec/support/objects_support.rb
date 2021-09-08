module ObjectsSupport
  def create_user(params = {})
    user = User.new(
      email: params[:email] || 'test@example.com',  
      password: params[:password] || 'password'
    )
    user.skip_confirmation!
    user.save!
    user
  end

  def create_post(params = {})
    Post.create!(
      body: params[:body] || 'Just a body',
      user: params[:user] || create_user
    )
  end
end

RSpec.configure do |config|
  config.include ObjectsSupport
end
