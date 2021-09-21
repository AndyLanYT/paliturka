class Api::V1::CommentsController < ApplicationController
  def index
    comments = Comment.all

    render json: comments
  end

  def show
    comment = Comment.find(params[:id])
  
    if comment
      render json: comment
    else
      render json: { status: 'Comment not found' }, status: :not_found
    end
  end

  def create
    post = Post.find(params[:post_id])
  
    if post
      comment = post.comments.build(comment_params.merge({ user_id: current_user.id, post_id: params[:post_id] }))
  
      if comment.save
        render json: { status: 'Successfully created!' }
      else
        render json: { error: 'Not saved!' }
      end
    else
      render json: { status: 'Post not found' }, status: :not_found
    end
  end

  def update
    comment = Comment.find(params[:id])
  
    if comment
      authorize comment
      comment.update(comment_params)

      render json: comment
    else
      render json: { status: 'Comment not found' }, status: :not_found
    end
  end

  def destroy
    comment = Comment.find(params[:id])
  
    if comment
      authorize comment
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
