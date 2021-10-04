class Api::V1::LikesController < ApplicationController
  def create
    post = Post.find_by(id: params[:post_id])
    authorize_manually Like, post, :create?
    LikeProcessing::Creator.create!(post, current_user)
    render json: { status: 'Successfuly liked!' }
  end

  def destroy
    post = Post.find_by(id: params[:post_id])
    like = Like.find_by(id: params[:id])
    authorize like, :destroy?
    LikeProcessing::Destroyer.destroy!(like, post, current_user)
    render json: { status: 'Successfuly unliked!' }
  end

  private

  def already_liked?
    Like.exists?(user_id: current_user.id, post_id: params[:post_id])
  end
end
