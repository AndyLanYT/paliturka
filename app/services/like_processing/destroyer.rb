class LikeProcessing::Destroyer < ServiceBase
  include LikeProcessing

  attr_reader :like, :user

  def initialize(like, user)
    super()

    @like = like
    @user = user
  end

  def self.destroy!(like, user)
    new(like, user).destroy!
  end

  def destroy!
    return unless @like
    return unless @post
    return unless already_liked?(@user.id, @post.id)

    @like.destroy
  end
end
