class Api::V1::LikesController < ApplicationController
  def create
    post = Post.find_by(id: params[:post_id])

    if post
      if already_liked?
        render json: { error: 'Can\'t be liked twice!' }
      else
        post.likes.create(user_id: current_user.id)
        render json: { status: 'Successfuly liked!' }
      end
    else
      render json: { status: 'Post not found' }, status: :not_found
    end
  end

  def destroy
    post = Post.find_by(id: params[:post_id])

    if post
      like = post.likes.find_by(id: params[:id])

      if like
        authorize like, :destroy?
        if already_liked?
          like.destroy
          render json: { status: 'Successfuly unliked!' }
        else
          render json: { status: 'Can\'t be unliked' }
        end
      else
        render json: { status: 'Like not found' }, status: :not_found
      end
    else
      render json: { status: 'Post not found' }, status: :not_found
    end
  end

  private

  def already_liked?
    Like.exists?(user_id: current_user.id, post_id: params[:post_id])
  end
end
