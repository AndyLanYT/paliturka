class CommentsController < ApplicationController
  def index
    comments = Comment.all

    render json: comments
  end

  def show
    comment = Comment.find(params[:id])

    render json: comment
  end

  def create
    comment = current_user.comments.new(comment_params)

    if comment.save
      render json: { status: 'Successfully created!' }
    else
      render json: { error: 'Not saved!' }
    end
  end

  def update
    comment = Comment.find(params[:id])
    comment.update(comment_params)

    render json: comment
  end

  def destroy
    comment = Comment.find(params[:id])

    if comment
      comment.destroy

      render json: { status: 'Successfully destroyed!' }
    else
      render json: { error: 'Comment not found!' }, status: :not_found
    end
  end

  private

  def comment_params
    params.require(:comment).permit(:body, :post)
  end
end