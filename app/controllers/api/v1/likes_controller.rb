class LikesController < ApplicationController
  def create
    post = Post.find(params[:post_id])

    if already_liked?
      render json: { error: 'Can\'t be liked twice!' }
    else
      post.likes.create(user_id: current_user.id)
      render json: { status: 'Successfuly liked!' }
    end
  end

  def destroy
    post = Post.find(params[:post_id])
    like = post.likes.find(params[:id])

    if already_liked?
      like.destroy
      render json: { status: 'Successfuly unliked!' }
    else
      render json: { status: 'Can\'t be unliked' }
    end
  end

  private

  def already_liked?
    Like.exists?(user_id: current_user.id, post_id: params[:post_id])
  end
end
