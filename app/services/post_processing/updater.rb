class PostProcessing::Updater < ServiceBase
  attr_reader :post, :post_params

  def initialize(post, post_params)
    super()

    @post = post
    @post_params = post_params
  end

  def self.update!(post, post_params)
    new(post, post_params).update!
  end

  def update!
    return unless @post

    @post.update(@post_params)
    @post
  end
end
