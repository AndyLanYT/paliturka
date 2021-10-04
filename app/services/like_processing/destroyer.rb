class LikeProcessing::Destroyer < ServiceBase
  include LikeProcessing

  attr_reader :like, :post, :user

  def initialize(like, post, user)
    super()

    @like = like
    @post = post
    @user = user
  end

  def self.destroy!(like, post, user)
    new(like, post, user).destroy!
  end

  def destroy!
    return unless @like
    return unless @post
    return unless already_liked?(@user.id, @post.id)

    @like.destroy
  end
end
