class LikeProcessing::Creator < ServiceBase
  include LikeProcessing

  attr_reader :post, :user

  def initialize(post, user)
    super()

    @post = post
    @user = user
  end

  def self.create!(post, user)
    new(post, user).create!
  end

  def create!
    return unless @post
    return if already_liked?(@user.id, @post.id)

    @post.likes.create(post: @post, user: @user)
  end
end
