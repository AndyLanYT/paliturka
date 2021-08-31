module ObjectsSupport
  def create_user(params = {})
    last_id = User.limit(1).order(id: :desc).pluck(:id).first || 0
    user = User.new(
      username: 'new_user',
      email: params[:name].present? ? "#{params[:name]}@test.com" : "testtest#{last_id+1}@test.com",
      password: '123456789',
      password_confirmation: '123456789'
    )
    user.skip_confirmation!
    user.save!
    user
  end
end

RSpec.configure do |config|
  config.include ObjectsSupport
end
