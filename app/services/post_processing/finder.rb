class PostProcessing::Finder < ServiceBase
  attr_reader :post

  def initialize(post)
    super()

    @post = post
  end

  def self.find!(post)
    new(post).find!
  end

  def find!
    Post.find_by(id: @post.id)
  end
end
