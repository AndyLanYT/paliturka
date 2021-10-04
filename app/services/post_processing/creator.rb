class PostProcessing::Creator < ServiceBase
  attr_reader :post_params, :user

  def initialize(post_params, user)
    super()

    @post_params = post_params
    @user = user
  end

  def self.create!(post_params, user)
    new(post_params, user).create!
  end

  def create!
    @user.posts.create(@post_params)
  end
end
