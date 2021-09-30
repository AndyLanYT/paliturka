class CommentProcessing::Finder < ServiceBase
  attr_reader :comment

  def initialize(comment)
    super()

    @comment = comment
  end

  def self.find!(comment)
    new(comment).find!
  end

  def find!
    Comment.find_by(id: @comment.id)
  end
end
