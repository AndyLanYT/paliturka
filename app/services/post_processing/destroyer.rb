class PostProcessing::Destroyer < ServiceBase
  attr_reader :post

  def initialize(post)
    super()

    @post = post
  end

  def self.destroy!(post)
    new(post).destroy!
  end

  def destroy!
    return unless @post

    @post.destroy!
  end
end
