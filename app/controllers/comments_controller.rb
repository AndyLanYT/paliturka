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
  end

  def update
    comment = Comment.find(params[:id])
    comment.update

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
    params.require(:comment).permit(:body)
  end

end
