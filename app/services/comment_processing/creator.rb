class CommentProcessing::Creator < ServiceBase
  attr_reader :comment_params, :user, :post

  def initialize(comment_params, user, post)
    super()

    @comment_params = comment_params
    @user = user
    @post = post
  end

  def self.create!(comment_params, user, post)
    new(comment_params, user, post).create!
  end

  def create!
    @post.comments.create(@comment_params.merge({ user_id: @user.id, post_id: @post.id }))
  end
end
