class CommentProcessing::Destroyer < ServiceBase
  attr_reader :comment

  def initialize(comment)
    super()

    @comment = comment
  end

  def self.destroy!(comment)
    new(comment).destroy!
  end

  def destroy!
    return unless @comment

    @comment.destroy
  end
end
