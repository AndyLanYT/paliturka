class CommentProcessing::Updater < ServiceBase
  attr_reader :comment, :comment_params

  def initialize(comment, comment_params)
    super()

    @comment = comment
    @comment_params = comment_params
  end

  def self.update!(comment, comment_params)
    new(comment, comment_params).update!
  end

  def update!
    return unless @comment

    @comment.update(@comment_params)
    @comment
  end
end
