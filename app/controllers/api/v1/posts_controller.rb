class Api::V1::PostsController < ApplicationController
  def index
    authorize Post, :index?
    posts = Post.all

    render json: posts
  end

  def show
    post = Post.find_by(id: params[:id])
    authorize post, :show?

    render json: post
  end

  def create
    authorize Post, :create?
    post = PostProcessing::Creator.create!(post_params, current_user)

    render json: post
  end

  def update
    post = Post.find_by(id: params[:id])
    authorize post, :update?
    updated_post = PostProcessing::Updater.update!(post, post_params)

    render json: updated_post
  end

  def destroy
    post = Post.find_by(id: params[:id])
    authorize post, :destroy?
    PostProcessing::Destroyer.destroy!(post)

    render json: { id: params[:id], message: 'Successfully destroyed!' }
  end

  private

  def post_params
    params.require(:post).permit(:body)
  end
end
