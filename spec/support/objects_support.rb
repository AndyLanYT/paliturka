module ObjectsSupport
  def create_user(params = {})
    last_id = User.limit(1).order(id: :desc).pick(:id) || 0
    user = User.new(
      email: params[:name].present? ? "#{params[:name]}@example.com" : "test#{last_id + 1}@example.com",
      password: 'password',
      password_confirmation: 'password'
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
